//
//  VolumeControlView.swift
//  CatsAndDogsTranslator
//
//  Created by Edward Gasparian on 14.02.2025.
//

import SwiftUI
import AVFoundation
import MediaPlayer

struct VolumeControlView: View {
    @State private var volume: Float = AVAudioSession.sharedInstance().outputVolume
    
    var body: some View {
        ZStack {

            AppGradients.backgroundGradient
                .ignoresSafeArea()
            
            VStack {
                Text("Volume Control")
                    .font(.title)
                    .bold()
                
                Slider(value: $volume, in: 0...1, step: 0.01)
                    .padding()
                    .onChange(of: volume) { oldValue, newValue in
                        setSystemVolume(to: newValue)
                    }
                
                Text("Current Volume: \(Int(volume * 100))%")
                    .font(.headline)
                    .padding(.bottom, 20)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 5)
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .tint(.black)
        .onAppear {
            observeVolumeChanges()
        }
    }
    
    private func setSystemVolume(to value: Float) {
        let volumeView = MPVolumeView()
        if let slider = volumeView.subviews.first(where: { $0 is UISlider }) as? UISlider {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                slider.value = value
            }
        }
    }
    
    private func observeVolumeChanges() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setActive(true)
        } catch {
            print("Audio session activation failed: \(error)")
        }
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("AVSystemController_SystemVolumeDidChangeNotification"), object: nil, queue: .main) { notification in
            if let userInfo = notification.userInfo,
               let newVolume = userInfo["AVSystemController_AudioVolumeNotificationParameter"] as? Float {
                Task { @MainActor in
                    self.volume = newVolume
                }
            }
        }
    }
}

#Preview {
    VolumeControlView()
}
