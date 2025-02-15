//
//  RatingView.swift
//  CatsAndDogsTranslator
//
//  Created by Edward Gasparian on 14.02.2025.
//

import SwiftUI

struct RatingView: View {
    @State private var rating: Int = 0
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Rate Our App")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("We value your feedback! Please rate our app.")
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
            
            HStack {
                ForEach(1...5, id: \.self) { star in
                    Image(systemName: star <= rating ? "star.fill" : "star")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(star <= rating ? .yellow : .gray)
                        .onTapGesture {
                            rating = star
                        }
                }
            }
            
            Button(action: submitRating) {
                Text("Submit")
                    .bold()
                    .frame(width: 200, height: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .disabled(rating == 0)
            
            Spacer()
        }
        .padding(.top, 150)
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(AppGradients.backgroundGradient)
        .ignoresSafeArea()
    }
    
    private func submitRating() {
        print("User rated: \(rating) stars")
    }
}

#Preview {
    RatingView()
}
