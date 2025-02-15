//
//  SoundClassifier.swift
//  CatsAndDogsTranslator
//
//  Created by Edward Gasparian on 13.02.2025.
//

import CoreML
import Vision
import UIKit

func createImage(from array: MLMultiArray) -> UIImage? {
    let width = 128
    let height = 128
    let bytesPerRow = width * 4
    let bitsPerComponent = 8
    let colorSpace = CGColorSpaceCreateDeviceRGB()
    let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.noneSkipFirst.rawValue)
    
    guard let context = CGContext(
        data: array.dataPointer,
        width: width,
        height: height,
        bitsPerComponent: bitsPerComponent,
        bytesPerRow: bytesPerRow,
        space: colorSpace,
        bitmapInfo: bitmapInfo.rawValue
    ) else { return nil }
    
    guard let cgImage = context.makeImage() else { return nil }
    return UIImage(cgImage: cgImage)
}
