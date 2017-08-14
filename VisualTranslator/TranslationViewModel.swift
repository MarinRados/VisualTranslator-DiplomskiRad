//
//  TranslationViewModel.swift
//  VisualTranslator
//
//  Created by Marin Rados on 08/06/2017.
//  Copyright © 2017 Marin Rados. All rights reserved.
//

import Foundation
import VisualRecognitionV3
import LanguageTranslatorV2
import RealmSwift

final class TranslationViewModel {
    
    var onTranslation: ((String) -> Void)?
    var onError: ((String) -> Void)?
    var onStartedActivity: (() -> Void)?
    var onEndedActivity: (() -> Void)?
    var onItemSaved: (() -> Void)?
    var onFinished: (() -> Void)?
    
    let image: Data?
    let defaultLanguage = Language(name: "English", abrv: "en")
    
    
    // MARK: - Dependecies
    
    var persistenceService: PersistenceServiceProtocol!
    
    init(image: Data, persistenceService: PersistenceServiceProtocol) {
        self.image = image
        self.persistenceService = persistenceService
    }
    
    func getImagePath() -> URL {
        let fileManager = FileManager.default
        let documentsPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        let imagePath = documentsPath?.appendingPathComponent("image.jpg")
        
        try! image?.write(to: imagePath!)
        return imagePath!
    }
    
    
    func getRecognition(onComplete: @escaping (([String])-> Void)) {
        onStartedActivity?()
        let apiKey = "69642e6b7d9e0f87db09537320921cdfd5a66f4a"
        let version = "2017-08-14"
        let visualRecognition = VisualRecognition(apiKey: apiKey, version: version)
        
        let url = getImagePath()
        visualRecognition.classify(
            imageFile: url,
            failure: { error in
            
                print(error as NSError)
            },
                                   
            success: { images in
            
            guard let firstImage = images.images.first,
            let firstClassifier = firstImage.classifiers.first else { return }
            
            let classes = firstClassifier.classes
            
            if classes.count < 4 {
                self.onError?("Too few recognition results, please try to take another picture.")
                return
            }
            
            let firstFour = classes.prefix(4)
            
            let recognitions = firstFour.map { $0.classification }
            
            DispatchQueue.main.async {
                self.onEndedActivity?()
                onComplete(recognitions)
            }
        })
    }
    
    func translate(_ word: String) {
        onStartedActivity?()
        let username = "c7b0dac6-a5e9-4fb5-9bd5-9dd0b403329e"
        let password = "4FJsYH5dZYI8"
        let languageTranslator = LanguageTranslator(username: username, password: password)
        
        guard let targetLanguage = persistenceService.currentLanguage?.abrv else { return }
        
        languageTranslator.translate(word,
                                     from: defaultLanguage.abrv,
                                     to: targetLanguage, failure: { (error) in
                                        print(error)
        }) { (translation) in
            
            guard let firstElement = translation.translations.first else { return }
            
            DispatchQueue.main.async {
                self.onEndedActivity?()
                self.onTranslation?(firstElement.translation)
            }
        }
    }
    
    func saveItem(original: String, translation: String, image: Data) {
        let realm = try! Realm()
        
        try! realm.write {
            let newItem = QuizQuestion()
            
            newItem.originalText = original
            newItem.translatedText = translation
            newItem.language = persistenceService.currentLanguage
            newItem.image = image
            
            realm.add(newItem)
        }
        onItemSaved?()
        let when = DispatchTime.now() + 1
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.onFinished?()
        }
    }
    
    func cancel() {
        onFinished?()
    }
}
