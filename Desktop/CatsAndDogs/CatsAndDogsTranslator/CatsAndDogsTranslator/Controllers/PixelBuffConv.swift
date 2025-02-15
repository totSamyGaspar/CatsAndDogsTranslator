//
//  PixelBuffConv.swift
//  CatsAndDogsTranslator
//
//  Created by Edward Gasparian on 13.02.2025.
//

import CoreML
import UIKit
import VideoToolbox

func convertToPixelBuffer(image: UIImage) -> CVPixelBuffer? {
    let width = 128
    let height = 128
    let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue,
         kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
    var pixelBuffer: CVPixelBuffer?
    
    let status = CVPixelBufferCreate(kCFAllocatorDefault, width, height,
                                     kCVPixelFormatType_32BGRA, attrs, &pixelBuffer)
    guard status == kCVReturnSuccess, let buffer = pixelBuffer else {
        return nil
    }
    
    CVPixelBufferLockBaseAddress(buffer, .init(rawValue: 0))
    let context = CGContext(data: CVPixelBufferGetBaseAddress(buffer),
                            width: width,
                            height: height,
                            bitsPerComponent: 8,
                            bytesPerRow: CVPixelBufferGetBytesPerRow(buffer),
                            space: CGColorSpaceCreateDeviceRGB(),
                            bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)
    
    guard let cgImage = image.cgImage else { return nil }
    context?.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
    CVPixelBufferUnlockBaseAddress(buffer, .init(rawValue: 0))
    
    return buffer
}
