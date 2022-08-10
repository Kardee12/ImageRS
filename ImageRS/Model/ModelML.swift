//
//  ModelML.swift
//  ImageRS
//
//  Created by Karthik Manishankar on 8/9/22.
//

import Foundation
import SwiftUI
import Social
import Vision
import CoreML
import ImageIO

extension CGImagePropertyOrientation {
    /// Converts an image orientation to a Core Graphics image property orientation.
    /// - Parameter orientation: A `UIImage.Orientation` instance.
    ///
    /// The two orientation types use different raw values.
    init(_ orientation: UIImage.Orientation) {
        switch orientation {
            case .up: self = .up
            case .down: self = .down
            case .left: self = .left
            case .right: self = .right
            case .upMirrored: self = .upMirrored
            case .downMirrored: self = .downMirrored
            case .leftMirrored: self = .leftMirrored
            case .rightMirrored: self = .rightMirrored
            @unknown default: self = .up
        }
    }
}

extension UIImage {
    
    func resizeImageTo(size: CGSize) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        self.draw(in: CGRect(origin: CGPoint.zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return resizedImage
    }
    
    func convertToBuffer() -> CVPixelBuffer? {
       
       let attributes = [
           kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue,
           kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue
       ] as CFDictionary
       
       var pixelBuffer: CVPixelBuffer?
       
       let status = CVPixelBufferCreate(
           kCFAllocatorDefault, Int(self.size.width),
           Int(self.size.height),
           kCVPixelFormatType_32ARGB,
           attributes,
           &pixelBuffer)
       
       guard (status == kCVReturnSuccess) else {
           return nil
       }
       
       CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
       
       let pixelData = CVPixelBufferGetBaseAddress(pixelBuffer!)
       let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
       
       let context = CGContext(
           data: pixelData,
           width: Int(self.size.width),
           height: Int(self.size.height),
           bitsPerComponent: 8,
           bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!),
           space: rgbColorSpace,
           bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)
       
       context?.translateBy(x: 0, y: self.size.height)
       context?.scaleBy(x: 1.0, y: -1.0)
       
       UIGraphicsPushContext(context!)
       self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
       UIGraphicsPopContext()
       
       CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
       
       return pixelBuffer
   }
}

class mlStuff{


    func detect(img: UIImage?) -> String{
        
        guard let newImageFix = img?.resizeImageTo(size: CGSize(width: 224, height:224 )) else{
            fatalError("Could not resize")
        }
        
        guard let convertedImg = newImageFix.convertToBuffer() else{
            fatalError("Could not convert to CVBuffer")
        }
        
        
        let model = MobileNetV2()
        
        guard let prediction = try? model.prediction(image: convertedImg) else{
            fatalError("Not readable")
        }
        
        let result = prediction.classLabel
    
        return result
}
}
