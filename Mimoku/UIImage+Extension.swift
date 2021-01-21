//
//  UIImage+Extension.swift
//  Mimoku_Example
//
//  Created by Mimosa on 2021/1/11.
//

import UIKit

// MARK: - Filters
extension UIImage {
    // MARK: Create Build In Filter Style Image
    // link: https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html
    func withBuildInFilter(filterName: String, parameter: [String : Any?] = [:]) -> UIImage? { guard
        let imageData = pngData(),
        let inputImage = CIImage(data: imageData),
        let filter = CIFilter(name: filterName)
        else { return nil }
        
        filter.setValue(inputImage, forKey: kCIInputImageKey)
        parameter.forEach { (p) in
            filter.setValue(p.value, forKey: p.key)
        }
        
        guard let outputImage = filter.outputImage,
              let outImage = CIContext().createCGImage(outputImage, from: outputImage.extent)
        else { return nil }
        
        return UIImage(cgImage: outImage)
    }
    
    static let buildInFilterEffect: [(String, [String : Any?])] = [
        ("CIPhotoEffectChrome", [:]), ("CIColorClamp", ["inputMaxComponents" : CIVector(x: 0.8, y: 0.8, z: 0.8, w: 0.8)]),
        ("CILinearToSRGBToneCurve", [:]), ("CISRGBToneCurveToLinear", [:]), ("CISepiaTone", [:]), ("CIEdges", [:]),
        ("CIPhotoEffectChrome", [:]), ("CIPhotoEffectFade", [:]), ("CIPhotoEffectInstant", [:]), ("CIPhotoEffectMono", [:]),
        ("CIPhotoEffectNoir", [:]), ("CIPhotoEffectProcess", [:]), ("CIPhotoEffectTonal", [:]), ("CIPhotoEffectTransfer", [:]),
        ("CIPointillize", [:]), ("CIPixellate", ["inputScale" : 14]), ("CIHexagonalPixellate", ["inputScale" : 16]),
        ("CILineOverlay", [:]), ("CIGloom", [:]), ("CICrystallize", [:]),
    ]
}
