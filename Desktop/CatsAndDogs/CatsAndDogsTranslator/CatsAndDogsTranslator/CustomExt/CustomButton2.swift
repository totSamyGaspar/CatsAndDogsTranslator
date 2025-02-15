//
//  CustomButton2.swift
//  CatsAndDogsTranslator
//
//  Created by Edward Gasparian on 12.02.2025.
//

import SwiftUI

struct CustomButton2: View {
    let title: String
    let destination: AnyView
    @State private var showSheet = false
    
    var body: some View {
        Button {
            showSheet.toggle()
        } label: {
            Color(hex: "#D6DCFF")
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .cornerRadius(20)
                .overlay {
                    HStack {
                        Text(title)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 15)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        Image("arrow-right")
                            .padding(.trailing, 15)
                    }
                }
        }
        .sheet(isPresented: $showSheet) {
            destination
        }
    }
}
