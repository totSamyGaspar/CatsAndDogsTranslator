//
//  CustomButton.swift
//  CatsAndDogsTranslator
//
//  Created by Edward Gasparian on 12.02.2025.
//

import SwiftUI

struct CustomButton: View {
    let title: String
    let imageName: String
    var destination: AnyView? = nil
    let action: (() -> Void)? = nil
    
    var body: some View {
        if let destination = destination {
            NavigationLink(destination: destination) {
                buttonContent
            }
        } else {
            Button(action: action ?? {}) {
                buttonContent
            }
        }
    }
    
    private var buttonContent: some View {
        Color.white
            .frame(width: 64, height: 44)
            .overlay {
                VStack {
                    Image(imageName)
                    Text(title)
                        .foregroundStyle(.black)
                        .font(.caption)
                        .fontWeight(.semibold)
                }
            }
    }
}


