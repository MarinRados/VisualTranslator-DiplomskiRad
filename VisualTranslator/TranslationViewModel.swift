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
    
    init(image: Data) {
        self.image = image
    }
    
    func getImagePath() -> URL {
        let fileManager = FileManager.default
        let documentsPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        let imagePath = documentsPath?.appendingPathComponent("image.jpg")
        
        try! image?.write(to: imagePath!)
        return imagePath!
    }
    
    
    func getRecognition(onComplete: @escaping (([String])-> Void)) {
        let apiKey = "610bace967b0f493493b683451fb2406e2b7e35c"
        let version = "2017-06-13"
        let visualRecognition = VisualRecognition(apiKey: apiKey, version: version)
        
        let url = getImagePath()
        visualRecognition.classify(imageFile: url) { images in
            
            let classes = images.images.first!.classifiers.first!.classes
            let firstFour = classes.prefix(4)
            
            let recognitions = firstFour.map { $0.classification }
            
            DispatchQueue.main.async {
                onComplete(recognitions)
            }
        }
    }
    
    func translate(_ word: String, to language: String) {
        let username = "1cfe3a91-781c-4077-9f2d-93a2ad04f30f"
        let password = "Y80zxVlNMDYJ"
        let languageTranslator = LanguageTranslator(username: username, password: password)
        
        languageTranslator.translate(word,
                                     from: defaultLanguage,
                                     to: language, failure: { (error) in
                                        print(error)
        }) { (translation) in
            
            DispatchQueue.main.async {
                self.onTranslation?(translation.translations.first!.translation)
            }
        }
    }
}
