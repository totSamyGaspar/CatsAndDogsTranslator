//
//  ArticleDetailView.swift
//  CatsAndDogsTranslator
//
//  Created by Edward Gasparian on 14.02.2025.
//

import SwiftUI

struct ArticleDetailView: View {
    let article: AnimalArticle
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                // Title
                Text(article.title)
                    .font(.title)
                    .bold()
                    .padding(.bottom, 10)
                
                // Image
                AsyncImage(url: URL(string: article.image)) { image in
                    image.resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                } placeholder: {
                    ProgressView()
                }
                .padding(.bottom, 10)
                
                // Article
                Text(article.content)
                    .font(.body)
                    .padding(.bottom, 10)
                
                Spacer()
            }
            .padding()
        }
        .padding(.top, 50)
        .navigationTitle("Article")
        .navigationBarTitleDisplayMode(.inline)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(AppGradients.backgroundGradient)
        .ignoresSafeArea()
    }
        
}


#Preview {
    ArticleDetailView(article: AnimalArticle(
        title: "Lion",
        category: "Animal",
        image: "https://example.com/lion.jpg",
        content: "The lion is a species in the family Felidae and a member of the genus Panthera."
    ))
}
