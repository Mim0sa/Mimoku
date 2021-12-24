//
//  Mimoku+CGRect.swift
//
//  Created by Mimosa.
//

import UIKit

extension CGSize {
    
    /// Get the AspectFit frame according to self.size
    /// - Parameter ratio: content size ratio
    /// - Returns: the AspectFit frame
    func getAspectFitRect(with ratio: CGFloat) -> CGRect {
        let r1 = width / height
        let r2 = ratio
        
        var rect = CGRect()
        if r1 > r2 {
            rect.size.height = height
            rect.size.width = height * r2
            rect.origin.y = 0
            rect.origin.x = (width - rect.size.width) / 2
        } else {
            rect.size.width = width
            rect.size.height = width / r2
            rect.origin.x = 0
            rect.origin.y = (height - rect.size.height) / 2
        }
        
        return rect
    }
    
    func getAspectFitRect(with size: CGSize) -> CGRect {
        return getAspectFitRect(with: size.width / size.height)
    }
    
}
