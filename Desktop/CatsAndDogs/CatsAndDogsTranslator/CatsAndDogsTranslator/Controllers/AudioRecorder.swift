//
//  AudioRecorder.swift
//  CatsAndDogsTranslator
//
//  Created by Edward Gasparian on 13.02.2025.
//

import Foundation
import AVFoundation
import CoreML
import Accelerate

@MainActor
final class AudioRecorder: NSObject, ObservableObject, AVAudioRecorderDelegate {
    private var audioRecorder: AVAudioRecorder?
    private let soundClassifier = SoundClassifier.shared
    
    @Published var isRecording = false
    @Published var prediction: String?
    
    func startRecording() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default, options: [.defaultToSpeaker, .allowBluetooth])
            try audioSession.setActive(true)
        } catch {
            print("Error creating audio session: \(error.localizedDescription)")
            return
        }
        
        let settings = [
            AVFormatIDKey: kAudioFormatMPEG4AAC,
            AVSampleRateKey: 44100.0,
            AVNumberOfChannelsKey: 1,
            AVEncoderBitRateKey: 128000,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ] as [String : Any]
        
        let url = FileManager.default.temporaryDirectory.appendingPathComponent("recording.m4a")
        
        do {
            audioRecorder = try AVAudioRecorder(url: url, settings: settings)
            audioRecorder?.delegate = self
            audioRecorder?.record()
            isRecording = true
        } catch {
            print("Error creating audio recorder: \(error)")
        }
    }
    
    func stopRecording() {
        audioRecorder?.stop()
        isRecording = false
        if let url = audioRecorder?.url {
            processAudio(url: url)
        }
    }
    
    func processAudio(url: URL) {
        guard let audioFile = try? AVAudioFile(forReading: url) else {
            print("Error opening audio file")
            return
        }
        
        let format = audioFile.processingFormat
        let frameCount = AVAudioFrameCount(audioFile.length)
        guard let buffer = AVAudioPCMBuffer(pcmFormat: format, frameCapacity: frameCount) else {
            print("Error building audio buffer")
            return
        }
        
        do {
            try audioFile.read(into: buffer)
        } catch {
            print("Error reading audio file: \(error)")
            return
        }
        
        // Converting to spectrogramm
        let fftLength = 512
        var real = [Float](repeating: 0.0, count: fftLength / 2)
        var imag = [Float](repeating: 0.0, count: fftLength / 2)
        
        // Creating UnsafeMutablePointer
        real.withUnsafeMutableBufferPointer { realPtr in
            imag.withUnsafeMutableBufferPointer { imagPtr in
                var splitComplex = DSPSplitComplex(realp: realPtr.baseAddress!, imagp: imagPtr.baseAddress!)
                
                guard let floatData = buffer.floatChannelData else {
                    print("Error getting floatChannelData")
                    return
                }
                
                floatData.pointee.withMemoryRebound(to: Float.self, capacity: fftLength) { floatBuffer in
                    vDSP_ctoz(UnsafePointer<DSPComplex>(OpaquePointer(floatBuffer)), 2, &splitComplex, 1, vDSP_Length(fftLength / 2))
                    vDSP_zvabs(&splitComplex, 1, realPtr.baseAddress!, 1, vDSP_Length(fftLength / 2))
                }
            }
        }
        
        guard let mlArray = try? MLMultiArray(shape: [1, NSNumber(value: fftLength / 2)], dataType: .float32) else {
            print("Error creating MLMultiArray")
            return
        }
        
        for i in 0..<real.count {
            mlArray[i] = NSNumber(value: real[i])
        }
        
        // Using soundClassifier
        if let prediction = soundClassifier?.predict(from: mlArray) {
            DispatchQueue.main.async {
                self.prediction = prediction
            }
        } else {
            print("Prediction failed")
        }
    }
}
