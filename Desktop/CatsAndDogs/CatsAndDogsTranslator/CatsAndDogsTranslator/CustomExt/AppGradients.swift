//
//  Gradient.swift
//  CatsAndDogsTranslator
//
//  Created by Edward Gasparian on 12.02.2025.
//

import SwiftUI

struct AppGradients {
    static let backgroundGradient = LinearGradient(
        gradient: Gradient(colors: [
            Color(hex: "#F3F5F6"),
            Color(hex: "#C9FFE0")
        ]),
        startPoint: .top,
        endPoint: .bottom
    )
}
