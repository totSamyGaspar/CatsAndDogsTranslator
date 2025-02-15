//
//  GIFView.swift
//  CatsAndDogsTranslator
//
//  Created by Edward Gasparian on 13.02.2025.
//

import SwiftUI
import SwiftyGif

struct GIFView: UIViewRepresentable {
    let gifName: String
    
    func makeUIView(context: Context) -> UIImageView {
        let imageView = UIImageView()
        do {
            let gif = try UIImage(gifName: gifName)
            imageView.setGifImage(gif, loopCount: -1)
        } catch {
            print("Ошибка загрузки GIF: \(error)")
        }
        return imageView
    }
    
    func updateUIView(_ uiView: UIImageView, context: Context) {}
}
