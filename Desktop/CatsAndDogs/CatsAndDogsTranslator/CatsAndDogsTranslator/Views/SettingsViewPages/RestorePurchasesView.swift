//
//  RestorePurchasesView.swift
//  CatsAndDogsTranslator
//
//  Created by Edward Gasparian on 14.02.2025.
//

import SwiftUI
import StoreKit

struct RestorePurchasesView: View {
    @State private var restoreSuccess = false
    @State private var restoreFailed = false
    
    var body: some View {
        ZStack {
            AppGradients.backgroundGradient
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Text("Restore Purchases")
                    .font(.title2)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                
                Image(systemName: "arrow.clockwise")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.blue)
                
                Button {
                    restorePurchases()
                } label: {
                    Text("Restore Purchases")
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
        .alert(isPresented: $restoreSuccess) {
            Alert(title: Text("Success"), message: Text("Your purchases have been restored."), dismissButton: .default(Text("OK")))
        }
        .alert(isPresented: $restoreFailed) {
            Alert(title: Text("Failed"), message: Text("Could not restore purchases. Please try again later."), dismissButton: .default(Text("OK")))
        }
    }
    
    private func restorePurchases() {
        Task {
            do {
                try await AppStore.sync()
                restoreSuccess = true
            } catch {
                restoreFailed = true
            }
        }
    }
}

#Preview {
    RestorePurchasesView()
}
