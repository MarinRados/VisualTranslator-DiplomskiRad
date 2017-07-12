//
//  LanguageViewModel.swift
//  VisualTranslator
//
//  Created by Marin Rados on 11/07/2017.
//  Copyright © 2017 Marin Rados. All rights reserved.
//

import Foundation


final class LanguageViewModel {
    
    var onComplete: (() -> Void)?
    
    // MARK: - Dependecies
    
    var persistenceService: PersistenceServiceProtocol!
    
    init(persistenceService: PersistenceServiceProtocol) {
        self.persistenceService = persistenceService
    }
    
    func changeCurrentLanguage(to language: Language) {
        self.persistenceService.currentLanguage = language
        onComplete?()
    }
    
    let languages: [Language] = [
        Language(name: "German", abrv: "de"),
        Language(name: "Spanish", abrv: "es"),
        Language(name: "French", abrv: "fr"),
        Language(name: "Italian", abrv: "it"),
        Language(name: "Portuguese", abrv: "pt")
    ]
    
    func cancel() {
        onComplete?()
    }
}
