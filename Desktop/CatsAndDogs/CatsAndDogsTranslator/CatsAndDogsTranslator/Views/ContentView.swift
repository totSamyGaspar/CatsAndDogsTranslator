//
//  ContentView.swift
//  CatsAndDogsTranslator
//
//  Created by Edward Gasparian on 14.02.2025.
//


import SwiftUI
import AVFoundation
import SwiftyGif

struct ContentView: View {
    
    @StateObject private var micManager = MicPermMngr()
    @StateObject private var audioRecorder = AudioRecorder()
    
    @State private var showLoadingView = false
    @State private var showResultView = false
    
    @State private var selectedPet: String = "dog"
    @State private var isHumanFirst: Bool = true
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer(minLength: 70)
                Text(Constants.mainTitle)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
                
                // MARK: - Language Switcher
                HStack {
                    Text(isHumanFirst ? Constants.humanTxt : Constants.petTxt)
                        .frame(width: 135, height: 61)
                    
                    Button {
                        isHumanFirst.toggle()
                    } label: {
                        Image(Constants.swapImg)
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                    
                    Text(isHumanFirst ? Constants.petTxt : Constants.humanTxt)
                        .frame(width: 135, height: 61)
                }
                .foregroundStyle(.black)
                .fontWeight(.semibold)
                
                // MARK: - Microphone Button & Pets
                Spacer()
                HStack {
                    Button {
                        if audioRecorder.isRecording {
                            audioRecorder.stopRecording()
                            showLoadingView = true
                        } else {
                            audioRecorder.startRecording()
                        }
                    } label: {
                        Color.white
                            .frame(width: 178, height: 178)
                            .clipShape(.rect(cornerRadius: 20))
                            .overlay {
                                VStack {
                                    if audioRecorder.isRecording {
                                        GIFView(gifName: Constants.gifVoice)
                                            .frame(width: 100, height: 100)
                                    } else {
                                        Image(Constants.micImg)
                                            .resizable()
                                            .frame(width: 100, height: 100)
                                    }
                                    Text(audioRecorder.isRecording ? "Recording..." : "Start Speak")
                                        .foregroundStyle(.black)
                                        .bold()
                                }
                            }
                    }
                    .cornerRadius(20)
                    .shadow(radius: 5)
                    .padding()
                    //MARK: - Pet Switcher
                    VStack {
                        Button {
                            selectedPet = "cat"
                        } label: {
                            Color(hex: "#D1E7FC")
                                .frame(width: 70, height: 70)
                                .cornerRadius(10)
                                .overlay {
                                    Image(Constants.cat2Img)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 40, height: 40)
                                }
                        }
                        
                        Button {
                            selectedPet = "dog"
                        } label: {
                            Color(hex: "#ECFBC7")
                                .frame(width: 70, height: 70)
                                .cornerRadius(10)
                                .overlay {
                                    Image(Constants.dog2Img)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 40, height: 40)
                                }
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(radius: 5)
                    .padding()
                }
                
                // MARK: - Pet Image
                Spacer()
                Image(selectedPet == "cat" ? Constants.cat2Img : Constants.dog2Img)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 184, height: 184)
                
                // MARK: - Bottom Buttons
                Spacer()
                ZStack {
                    HStack {
                        NavigationLink {
                            TranslatorPageView()
                        } label: {
                            Color.white
                                .frame(width: 64, height: 44)
                                .overlay {
                                    VStack {
                                        Image(Constants.msg2Img)
                                        Text(Constants.mainTitle)
                                            .foregroundStyle(.black)
                                            .font(.caption)
                                            .fontWeight(.semibold)
                                    }
                                }
                        }
                        .alert("Enable Microphone Access", isPresented: $micManager.showPermissionAlert) {
                            Button("Cancel", role: .cancel) {}
                            Button("Settings") {
                                if let url = URL(string: UIApplication.openSettingsURLString) {
                                    UIApplication.shared.open(url)
                                }
                            }
                        } message: {
                            Text("Please allow access to your microphone to use the app’s features")
                        }
                        .padding(.trailing)
                        
                        NavigationLink {
                            SettingsView()
                        } label: {
                            Color.white
                                .frame(width: 64, height: 44)
                                .overlay {
                                    VStack {
                                        Image(Constants.groupImg)
                                        Text(Constants.clickerTxt)
                                            .foregroundStyle(.black)
                                            .font(.caption)
                                            .fontWeight(.semibold)
                                    }
                                }
                        }
                        .padding(.leading)
                    }
                }
                .padding()
                .frame(width: 216, height: 82)
                .background(Color.white)
                .cornerRadius(20)
                .shadow(radius: 5)
                .padding(.bottom, 40)
                .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(AppGradients.backgroundGradient)
            .ignoresSafeArea()
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .tint(.black)
            .onAppear {
                micManager.checkMicrophoneStatus()
            }
            
            // MARK: - Transition to LoadingView
            .navigationDestination(isPresented: $showLoadingView) {
                LoadingView(prediction: audioRecorder.prediction ?? "Repeat", selectedPet: selectedPet)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            showResultView = true
                        }
                    }
            }
            
            // MARK: - Transition to ResultView
            .navigationDestination(isPresented: $showResultView) {
                ResultView(prediction: audioRecorder.prediction ?? "Repeat", selectedPet: selectedPet)
            }
        }
    }
}

#Preview {
    ContentView()
}
