//
//  ScoreViewModel.swift
//  VisualTranslator
//
//  Created by Marin Rados on 19/07/2017.
//  Copyright © 2017 Marin Rados. All rights reserved.
//

import Foundation

final class ScoreViewModel {
    
    var onGoToMenu: (() -> Void)?
    
    func goToMenu() {
        onGoToMenu?()
    }
}
