//
//  PrivacyPolicyView.swift
//  CatsAndDogsTranslator
//
//  Created by Edward Gasparian on 14.02.2025.
//

import SwiftUI

struct PrivacyPolicyView: View {
    @Environment(\.dismiss) var dismiss
    let privacyPolicyURL = URL(string: "https://your-privacy-policy-link.com")!
    
    var body: some View {
        ZStack {
            AppGradients.backgroundGradient
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Text("Privacy Policy")
                    .font(.title2)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                
                Image(systemName: "lock.shield")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.blue)
                
                Button {
                    openPrivacyPolicy()
                } label: {
                    Text("View Policy")
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
    
    private func openPrivacyPolicy() {
        if UIApplication.shared.canOpenURL(privacyPolicyURL) {
            UIApplication.shared.open(privacyPolicyURL)
        }
    }
}

#Preview {
    PrivacyPolicyView()
}
