//
//  ResultView.swift
//  CatsAndDogsTranslator
//
//  Created by Edward Gasparian on 14.02.2025.
//

import SwiftUI
import AVFoundation

struct ResultView: View {
    
    var prediction: String
    let selectedPet: String
    
    var body: some View {
        NavigationStack {
            
            VStack {
                Spacer()
                HStack(alignment: .center) {
                    NavigationLink {
                        ContentView()
                    } label: {
                        Color.white
                            .clipShape(.circle)
                            .frame(width: 40, height: 40)
                            .overlay {
                                Image(systemName: Constants.xcSymb)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 28, height: 28)
                                    .foregroundColor(.black)
                            }
                    }
                    .padding()
                    Spacer()
                    Text(Constants.resultTxt)
                        .font(.system(size: 32, weight: .bold, design: .default))
                        .foregroundColor(.black)
                    Spacer(minLength: 150)
                }
                Spacer()
                
                Color(hex: "#D6DCFF")
                    .frame(width: 291, height: 142)
                    .clipShape(.rect(cornerRadius: 20))
                    .overlay {
                        Text(prediction)
                        Image(Constants.polyImg)
                            .padding(.top, 240)
                            .padding(.leading, 150)
                    }
                
                Spacer()
                
                Image(selectedPet == "cat" ? Constants.cat2Img : Constants.dog2Img)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 184, height: 184)
                
                Spacer(minLength: 150)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(AppGradients.backgroundGradient)
            .ignoresSafeArea()
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .tint(.black)
            
        }
    }
}

#Preview {
    ResultView(prediction: "Hello!", selectedPet: "cat")
}
