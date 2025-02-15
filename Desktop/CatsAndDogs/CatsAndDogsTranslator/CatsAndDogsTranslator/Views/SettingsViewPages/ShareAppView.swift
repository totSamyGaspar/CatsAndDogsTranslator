//
//  ShareAppView.swift
//  CatsAndDogsTranslator
//
//  Created by Edward Gasparian on 14.02.2025.
//

import SwiftUI

struct ShareAppView: View {
    let appURL = URL(string: "https://apps.apple.com/app/idYOUR_APP_ID") // Replace with your URL
    
    var body: some View {
        ZStack {
            AppGradients.backgroundGradient
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Text("Share this app with your friends!")
                    .font(.title2)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                
                Image(systemName: "square.and.arrow.up")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.blue)
                
                Button {
                    shareApp()
                } label: {
                    Text("Share")
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
    
    private func shareApp() {
        guard let url = appURL else { return }
        
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootVC = windowScene.windows.first?.rootViewController {
            rootVC.present(activityVC, animated: true, completion: nil)
        }
    }
}

#Preview {
    ShareAppView()
}
