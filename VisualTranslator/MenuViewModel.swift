//
//  MenuViewModel.swift
//  VisualTranslator
//
//  Created by Marin Rados on 17/07/2017.
//  Copyright © 2017 Marin Rados. All rights reserved.
//

import Foundation
import RealmSwift

final class MenuViewModel {
    
    var onGoToQuiz: ((Bool, Difficulty) -> Void)?
    var onError: ((String) -> Void)?
    let realm = try! Realm()
    let persistenceService: PersistenceServiceProtocol
    
    init(persistenceService: PersistenceServiceProtocol) {
        self.persistenceService = persistenceService
    }
    
    func goToQuizWith(pictures: Bool, difficulty: Difficulty) {
        
        if difficulty == .easy {
            if let language = persistenceService.currentLanguage?.abrv {
                
                let objects = Array(realm.objects(QuizQuestion.self).filter("language.abrv == %@", language))
                
                let easyObjects = objects.filter { $0.translatedText.characters.count < 8 }
                
                if easyObjects.count < 10 {
                    onError?("You need at least 10 items with words shorter than 8 letters to form an easy quiz in current language, please take more photos and save more items.")
                    return
                }
            } else {
                onError?("Couldn't detect current language!")
                return
            }
        } else {
            if let language = persistenceService.currentLanguage?.abrv {
                let objects = realm.objects(QuizQuestion.self).filter("language.abrv == %@", language)
                
                if objects.count < 10 {
                    onError?("You need at least 10 items to form a quiz in current language, please take more photos and save more items.")
                    return
                }
            } else {
                onError?("Couldn't detect current language!")
                return
            }
        }
        
        onGoToQuiz?(pictures, difficulty)
    }
}
