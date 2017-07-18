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
        let apiKey = "313aa2d25dafe93ac0264926740d7701c04603bb"
        let version = "2017-06-13"
        let visualRecognition = VisualRecognition(apiKey: apiKey, version: version)
        
        let url = getImagePath()
        visualRecognition.classify(imageFile: url) { images in
            
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
                onComplete(recognitions)
            }
        }
    }
    
    func translate(_ word: String) {
        let username = "961cf80d-6688-4015-be8e-1dfd415687a1"
        let password = "uFYZg0WRBKpt"
        let languageTranslator = LanguageTranslator(username: username, password: password)
        
        guard let targetLanguage = persistenceService.currentLanguage?.abrv else { return }
        
        languageTranslator.translate(word,
                                     from: defaultLanguage.abrv,
                                     to: targetLanguage, failure: { (error) in
                                        print(error)
        }) { (translation) in
            
            guard let firstElement = translation.translations.first else { return }
            
            DispatchQueue.main.async {
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
            
            print("U realmu: \(realm.objects(QuizQuestion.self))")
        }
    }
}
