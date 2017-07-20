//
//  ScoreViewModel.swift
//  VisualTranslator
//
//  Created by Marin Rados on 19/07/2017.
//  Copyright © 2017 Marin Rados. All rights reserved.
//

import Foundation

final class ScoreViewModel {
    
    var points: Int = 0
    var withImage: Bool!
    var difficulty: Difficulty!
    var modifier: String = ""
    var persistenceService: PersistenceServiceProtocol
    
    var onGoToMenu: (() -> Void)?
    
    init(points: Int, withImage: Bool, difficulty: Difficulty, persistenceService: PersistenceServiceProtocol) {
        self.points = points
        self.withImage = withImage
        self.difficulty = difficulty
        self.persistenceService = persistenceService
    }
    
    func getTotalPoints() {
        
        var pointsWithModifier = 0
        
        switch difficulty as Difficulty {
        case .easy:
            if !withImage {
                pointsWithModifier = points * 3
                modifier = "x3"
            } else {
                pointsWithModifier = points
                modifier = "x1"
            }
        case .hard:
            if withImage {
                pointsWithModifier = points * 2
                modifier = "x2"
            } else {
                pointsWithModifier = points * 4
                modifier = "x4"
            }
        }
        
        persistenceService.totalScore += pointsWithModifier
    }
    
    func goToMenu() {
        onGoToMenu?()
    }
    
}
