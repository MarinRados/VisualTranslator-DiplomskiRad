//
//  UIIMage+Extensions.swift
//  VisualTranslator
//
//  Created by Marin Rados on 08/06/2017.
//  Copyright © 2017 Marin Rados. All rights reserved.
//

import UIKit

extension UIImage {
    
    func scaled() -> UIImage {
        
        let width = self.size.width / 3
        let height = self.size.height / 3
        
        let size = CGSize(width: width, height: height)
        
        UIGraphicsBeginImageContext(size)
        self.draw(in: CGRect(origin: .zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    func uploadDataWithoutResize() -> Data? {
        return UIImageJPEGRepresentation(self.scaled(), 0.7)
    }
}
