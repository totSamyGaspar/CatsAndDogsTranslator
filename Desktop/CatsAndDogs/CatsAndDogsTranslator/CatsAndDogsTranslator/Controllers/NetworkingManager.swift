//
//  NetworkingManager.swift
//  CatsAndDogsTranslator
//
//  Created by Edward Gasparian on 14.02.2025.
//

import Foundation

@MainActor
class NetworkingManager: ObservableObject {
    static let shared = NetworkingManager()
    
    func fetchAnimalInfo(for animal: String) async throws -> AnimalArticle {
        let urlString = "https://en.wikipedia.org/api/rest_v1/page/summary/\(animal)"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decodedData = try JSONDecoder().decode(WikipediaArticle.self, from: data)
        return AnimalArticle(
            title: decodedData.title,
            category: "Animal",
            image: decodedData.thumbnail?.source ?? "",
            content: decodedData.extract
        )
    }
}

// MARK: - Data Models
struct WikipediaArticle: Codable {
    let title: String
    let extract: String
    let thumbnail: Thumbnail?
}

struct Thumbnail: Codable {
    let source: String
}


struct AnimalArticle: Identifiable, Codable, Hashable {
    let id: UUID = UUID()
    let title: String
    let category: String
    let image: String
    let content: String
    
    private enum CodingKeys: String, CodingKey {
        case title, category, image, content
    }
}
