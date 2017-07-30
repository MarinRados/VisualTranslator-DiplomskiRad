//
//  UIIMage+Extensions.swift
//  VisualTranslator
//
//  Created by Marin Rados on 08/06/2017.
//  Copyright © 2017 Marin Rados. All rights reserved.
//

import UIKit

extension UIImage {
    
    func resized(toWidth width: CGFloat) -> UIImage {
        
        let cgImage = self.cgImage!
        
        let aspectRatio = self.size.height / self.size.width
        let height = width * aspectRatio
        
        let context = CGContext(
            data: nil,
            width: Int(width),
            height: Int(height),
            bitsPerComponent: cgImage.bitsPerComponent,
            bytesPerRow: cgImage.bytesPerRow,
            space: cgImage.colorSpace!,
            bitmapInfo: cgImage.bitmapInfo.rawValue
        )
        
        context?.interpolationQuality = .default
        
        context?.draw(cgImage, in: CGRect(origin: .zero, size: CGSize(width: width, height: height)))
        
        return context?.makeImage().flatMap(UIImage.init) ?? UIImage()
    }
    
    func uploadData(resizedToWidth width: CGFloat) -> Data? {
        
        let resized = self.resized(toWidth: width)
        return UIImageJPEGRepresentation(resized, 1)
    }
    
    func uploadDataWithoutResize() -> Data? {
        return UIImageJPEGRepresentation(self, 1)
    }
    
    func fixOrientation() -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        self.draw(in: CGRect(x: 0.0, y: 0.0, width: self.size.width, height: self.size.height))
        let normalizedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return normalizedImage;
    }
}
