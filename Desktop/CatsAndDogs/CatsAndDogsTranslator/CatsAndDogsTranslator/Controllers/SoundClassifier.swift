//
//  SoundClassifier.swift
//  CatsAndDogsTranslator
//
//  Created by Edward Gasparian on 13.02.2025.
//

import CoreML
import UIKit

@MainActor
final class SoundClassifier {
    static let shared = SoundClassifier()
    let model: sound_classifier
    
    init?() {
        do {
            model = try sound_classifier(configuration: MLModelConfiguration())
        } catch {
            print("Model loading failed: \(error)")
            return nil
        }
    }
    
    func predict(from spectrogram: MLMultiArray) -> String? {
        do {
            if let image = createImage(from: spectrogram),
               let pixelBuffer = convertToPixelBuffer(image: image) {
                
                let input = sound_classifierInput(conv2d_input: pixelBuffer)
                let output = try model.prediction(input: input)
                
                let probabilities = output.Identity

                let probabilityArray = probabilities.toArray()
        
                if let maxIndex = probabilityArray.firstIndex(of: probabilityArray.max()!) {
                    
                    let labels = ["Hello, what are you doing?", "I'm hungry, feed me!", "I'm okay!", "Beware!"]
                    return labels[maxIndex]
                }
            }
        } catch {
            print("Prediction error: \(error)")
        }
        return nil
    }
}
extension MLMultiArray {
    func toArray() -> [Float] {
        return (0..<self.count).map { self[$0].floatValue }
    }
}
