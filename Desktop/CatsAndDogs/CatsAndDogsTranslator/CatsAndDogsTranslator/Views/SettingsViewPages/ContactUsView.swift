//
//  ContactUsView.swift
//  CatsAndDogsTranslator
//
//  Created by Edward Gasparian on 14.02.2025.
//

import SwiftUI
import MessageUI

struct ContactUsView: View {
    @State private var isShowingMailView = false
    @State private var showAlert = false
    
    private let supportEmail = "support@yourapp.com"
    
    var body: some View {
        ZStack {
            AppGradients.backgroundGradient
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Text("Contact Us")
                    .font(.title2)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                
                Image(systemName: "envelope")
                    .resizable()
                    .frame(width: 80, height: 60)
                    .foregroundColor(.blue)
                
                Button {
                    sendEmail()
                } label: {
                    Text("Send Email")
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
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Email Not Available"),
                message: Text("Your device does not support email sending."),
                dismissButton: .default(Text("OK"))
            )
        }
    }
    
    private func sendEmail() {
        guard let emailURL = URL(string: "mailto:\(supportEmail)") else {
            showAlert = true
            return
        }
        UIApplication.shared.open(emailURL)
    }
}

#Preview {
    ContactUsView()
}
