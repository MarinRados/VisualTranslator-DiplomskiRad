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
    
    // MARK: - Navigation
    
    func goToTranslation(image: Data) {
        onGoToTranslation?(image)
    }
}
