//
//  MicPermMngr.swift
//  CatsAndDogsTranslator
//
//  Created by Edward Gasparian on 12.02.2025.
//

import AVFoundation
import SwiftUI

@MainActor
class MicPermMngr: ObservableObject {
    @Published var isMicrophoneAccessGranted = false
    @Published var showPermissionAlert = false
    
    func checkMicrophoneStatus() {
        if #available(iOS 17.0, *) {
            let status = AVAudioApplication.shared.recordPermission
            
            switch status {
            case .granted:
                isMicrophoneAccessGranted = true
            case .denied:
                showPermissionAlert = true
            case .undetermined:
                Task { await requestMicrophoneAccess() }
            @unknown default:
                break
            }
        } else {
            switch AVAudioSession.sharedInstance().recordPermission {
            case .granted:
                isMicrophoneAccessGranted = true
            case .denied:
                showPermissionAlert = true
            case .undetermined:
                Task { await requestMicrophoneAccess() }
            @unknown default:
                break
            }
        }
    }
    
    func requestMicrophoneAccess() async {
        if #available(iOS 17.0, *) {
            let granted = await AVAudioApplication.requestRecordPermission()
            isMicrophoneAccessGranted = granted
            if !granted {
                showPermissionAlert = true
            }
        }
    }
}
