//
//  QuizPageViewModel.swift
//  VisualTranslator
//
//  Created by Marin Rados on 14/07/2017.
//  Copyright © 2017 Marin Rados. All rights reserved.
//

import Foundation
import RealmSwift

enum Difficulty {
    case easy
    case hard
}

final class QuizPageViewModel {
    
    let realm = try! Realm()
    var pickedDifficulty: Difficulty!
    var withImage: Bool!
    var persistenceService: PersistenceServiceProtocol
    
    var language: String {
        return persistenceService.currentLanguage?.abrv ?? "de"
    }
    
    init(pickedDifficulty: Difficulty, withImage: Bool, persistenceService: PersistenceServiceProtocol) {
        self.pickedDifficulty = pickedDifficulty
        self.withImage = withImage
        self.persistenceService = persistenceService
    }
    
    func getQuestions(language: String, difficulty: Difficulty) -> [QuizQuestion] {
        
        let allQuestions: Results<QuizQuestion>
        
        switch difficulty {
        case .easy:
            allQuestions = realm.objects(QuizQuestion.self).filter("language.abrv == %@", language)
        case .hard:
            allQuestions = realm.objects(QuizQuestion.self).filter("language.abrv == %@", language)
        }
        
        let maxQuestionCount = min(10, allQuestions.count)
        
        return (1...maxQuestionCount)
            .reduce([]) { (acc, i)-> [(index: Int, QuizQuestion)] in
                
                var randomNum: Int
                
                let indices = acc.map { $0.0 }
                
                repeat {
                    randomNum = Int(arc4random_uniform(UInt32(allQuestions.count)))
                } while indices.contains(randomNum)
                
                return acc + [(randomNum, allQuestions[randomNum])]
            }
            .map { $0.1 }
    }
}
