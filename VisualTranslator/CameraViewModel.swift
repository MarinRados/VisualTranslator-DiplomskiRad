//
//  CameraViewModel.swift
//  VisualTranslator
//
//  Created by Marin Rados on 08/06/2017.
//  Copyright © 2017 Marin Rados. All rights reserved.
//

import Foundation

final class CameraViewModel {
    
    // MARK: - Callbacks
    
    var onGoToTranslation: ((Data) -> Void)?
    var onGoToLanguage: (() -> Void)?
    
    // MARK: - Dependecies
    
    var persistenceService: PersistenceServiceProtocol!
    
    init(persistenceService: PersistenceServiceProtocol) {
        self.persistenceService = persistenceService
    }
    
    var currentLanguage: Language {
        return persistenceService.currentLanguage ?? Language()
    }
    
    // MARK: - Navigation
    
    func goToTranslation(image: Data) {
        onGoToTranslation?(image)
    }
    
    func goToLanguage() {
        onGoToLanguage?()
    }
}
