//
//  TranslatorPageView.swift
//  CatsAndDogsTranslator
//
//  Created by Edward Gasparian on 14.02.2025.
//

import SwiftUI

struct TranslatorPageView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var micManager = MicPermMngr()
    @StateObject private var audioRecorder = AudioRecorder()
    
    @State private var showLoadingView = false
    @State private var showResultView = false
    
    @State private var selectedPet: String? = "cat"
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Spacer()
                    
                    // MARK: - Recording Button
                    Button {
                        if audioRecorder.isRecording {
                            audioRecorder.stopRecording()
                            // Show LoadingView before ResultView
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
                                    Text(audioRecorder.isRecording ? "Recording..." : "Chat with a Veterinarian 1:1")
                                        .foregroundStyle(.black)
                                        .fontWeight(.semibold)
                                }
                            }
                    }
                    .cornerRadius(20)
                    .shadow(radius: 5)
                    .padding()
                    
                    // MARK: - Pets choose buttons
                    HStack {
                        Button {
                            selectedPet = "cat"
                        } label: {
                            Color(hex: selectedPet == "cat" ? "#A1C4FD" : "#D1E7FC")
                                .frame(width: 90, height: 90)
                                .clipShape(.circle)
                                .overlay {
                                    Image(Constants.cat1Img)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 60, height: 60)
                                        .padding(.top, 10)
                                }
                        }
                        .padding(.trailing, 50)
                        
                        Button {
                            selectedPet = "dog"
                        } label: {
                            Color(hex: selectedPet == "dog" ? "#A1C4FD" : "#ECFBC7")
                                .frame(width: 90, height: 90)
                                .clipShape(.circle)
                                .overlay {
                                    Image(Constants.dog1Img)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 60, height: 60)
                                }
                        }
                        .padding(.leading, 50)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(radius: 3)
                    .padding()
                    
                    // MARK: - Bottom Buttons
                    HStack {
                        CustomButton(title: Constants.mainTitle,
                                     imageName: Constants.msg2Img,
                                     destination: AnyView(ContentView()))
                        
                        CustomButton(title: Constants.clickerTxt,
                                     imageName: Constants.groupImg,
                                     destination: AnyView(SettingsView()))
                        
                        CustomButton(title: Constants.soundsTxt,
                                     imageName: Constants.volumeImg,
                                     destination: AnyView(VolumeControlView()))
                        
                        CustomButton(title: Constants.articlesTxt,
                                     imageName: Constants.articleImg,
                                     destination: AnyView(ArticleView()))
                    }
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: 82)
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(radius: 3)
                    .padding()
                }
                .padding()
                .padding(.bottom, 20)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(AppGradients.backgroundGradient)
            .ignoresSafeArea()
            .navigationBarBackButtonHidden(true)
            
            // MARK: - Transition to LoadingView
            .navigationDestination(isPresented: $showLoadingView) {
                LoadingView(prediction: audioRecorder.prediction ?? "Repeat", selectedPet: selectedPet ?? "cat")
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            showResultView = true
                        }
                    }
            }
            
            // MARK: - Transition to ResultView
            .navigationDestination(isPresented: $showResultView) {
                ResultView(prediction: audioRecorder.prediction ?? "Repeat", selectedPet: selectedPet ?? "cat")
            }
            
            // MARK: - Toolbar
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text(Constants.mainTitle)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        SettingsView()
                    } label: {
                        Color.white
                            .clipShape(.circle)
                            .frame(width: 40, height: 40)
                            .overlay {
                                Image(systemName: Constants.gearSymb)
                                    .foregroundColor(.black)
                            }
                    }
                    .padding()
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        TranslatorPageView()
    }
}
