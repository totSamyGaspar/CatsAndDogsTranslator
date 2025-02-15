//
//  ArticleView.swift
//  CatsAndDogsTranslator
//
//  Created by Edward Gasparian on 14.02.2025.
//

import SwiftUI

struct ArticleView: View {
    @State private var articles: [AnimalArticle] = []
    @State private var selectedArticle: AnimalArticle?
    
    var body: some View {
        NavigationStack {
            ZStack {
                AppGradients.backgroundGradient
                    .ignoresSafeArea()
                
                VStack {
                    List(articles) { article in
                        Button {
                            selectedArticle = article
                        } label: {
                            HStack {
                                AsyncImage(url: URL(string: article.image)) { image in
                                    image.resizable().scaledToFit().clipShape(.rect(cornerRadius: 5)).shadow(radius: 3)
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 60, height: 60)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .shadow(radius: 3)
                                VStack(alignment: .leading) {
                                    Text(article.title)
                                        .font(.headline)
                                        .foregroundColor(.black)
                                    Text(article.category)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }
                    .scrollContentBackground(.hidden)
                }
            }
            .navigationTitle("Animal Articles")
            .onAppear {
                Task {
                    await loadArticles()
                }
            }
            .sheet(item: $selectedArticle) { article in
                ArticleDetailView(article: article)
            }
        }
    }
    
    func loadArticles() async {
        let animals = ["Lion", "Tiger", "Capybara", "Cat", "Dog", "Raccoon", "Snake", "Horse", "Penguin"]
        for animal in animals {
            do {
                let article = try await NetworkingManager.shared.fetchAnimalInfo(for: animal)
                DispatchQueue.main.async {
                    articles.append(article)
                }
            } catch {
                print("Error fetching article for \(animal): \(error)")
            }
        }
    }
}

#Preview {
    ArticleView()
}
