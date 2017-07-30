//
//  UIButtonStyles.swift
//  VisualTranslator
//
//  Created by Marin Rados on 18/07/2017.
//  Copyright © 2017 Marin Rados. All rights reserved.
//

import Foundation

enum UIButtonStyles {
    static let base = UIViewStyle<UIButton> { _ in
        //
    }
    
    static let action = base.composing { button in
        button.layer.cornerRadius = 2.5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.clear.cgColor
    }
    
    static let bigButton = action.composing { button in
        button.backgroundColor = .black
        button.tintColor = .white
    }
}
