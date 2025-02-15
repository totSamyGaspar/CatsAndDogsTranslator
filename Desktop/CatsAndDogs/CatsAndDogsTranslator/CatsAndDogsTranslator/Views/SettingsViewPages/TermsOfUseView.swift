//
//  TermsOfUseView.swift
//  CatsAndDogsTranslator
//
//  Created by Edward Gasparian on 14.02.2025.
//

import SwiftUI

struct TermsOfUseView: View {
    @Environment(\.dismiss) var dismiss
    let termsOfUseURL = URL(string: "https://your-terms-of-use-link.com")!
    
    var body: some View {
        ZStack {
            AppGradients.backgroundGradient
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Text("Terms of Use")
                    .font(.title2)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                
                Image(systemName: "doc.text")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.blue)
                
                Button {
                    openTermsOfUse()
                } label: {
                    Text("View Terms")
                        .frame(width: 200, height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .fontWeight(.bold)
                }
                
                Spacer()
            }
            .padding(.top, 150)
            .padding()
        }
    }
    
    private func openTermsOfUse() {
        if UIApplication.shared.canOpenURL(termsOfUseURL) {
            UIApplication.shared.open(termsOfUseURL)
        }
    }
}

#Preview {
    TermsOfUseView()
}
