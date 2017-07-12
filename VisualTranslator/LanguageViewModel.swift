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
    
    func cancel() {
        onComplete?()
    }
}
