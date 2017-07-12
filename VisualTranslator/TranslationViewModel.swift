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

final class TranslationViewModel {
    
    var onTranslation: ((String) -> Void)?
    
    let image: Data?
    let defaultLanguage = "en"
    
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
                                     from: defaultLanguage,
                                     to: targetLanguage, failure: { (error) in
                                        print(error)
        }) { (translation) in
            
            guard let firstElement = translation.translations.first else { return }
            
            DispatchQueue.main.async {
                self.onTranslation?(firstElement.translation)
            }
        }
    }
}
