//
//  MenuViewModel.swift
//  VisualTranslator
//
//  Created by Marin Rados on 17/07/2017.
//  Copyright © 2017 Marin Rados. All rights reserved.
//

import Foundation

final class MenuViewModel {
    
    var onGoToQuiz: ((Bool, Difficulty) -> Void)?
    
    
    func goToQuizWith(pictures: Bool, difficulty: Difficulty) {
        onGoToQuiz?(pictures, difficulty)
    }
}
