//
//  LoadingView.swift
//  CatsAndDogsTranslator
//
//  Created by Edward Gasparian on 14.02.2025.
//

import SwiftUI

struct LoadingView: View {
    @State private var navigateToResult = false
    var prediction: String
    let selectedPet: String
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                Text("Process of translation...")
                    .font(.title2)
                    .bold()
                
                Spacer()
                
                Image(selectedPet == "cat" ? Constants.cat2Img : Constants.dog2Img)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 184, height: 184)
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(AppGradients.backgroundGradient)
            .ignoresSafeArea()
            .navigationBarBackButtonHidden(true)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // Delay 2 sec before transition to result screen
                    navigateToResult = true
                }
            }
            .navigationDestination(isPresented: $navigateToResult) {
                ResultView(prediction: prediction, selectedPet: selectedPet)
            }
        }
    }
}

#Preview {
    LoadingView(prediction: "Wowo", selectedPet: "cat")
}
