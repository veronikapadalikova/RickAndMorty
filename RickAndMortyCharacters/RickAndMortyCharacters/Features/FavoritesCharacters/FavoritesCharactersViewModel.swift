//
//  FavoritesCharactersViewModel.swift
//  RickAndMortyCharacters
//
//  Created by Veronika Padalíková on 12.01.2025.
//

import SwiftUI
import SwiftData

@MainActor
class FavoritesCharactersViewModel: ObservableObject {
    
    @Published var favoritesCharacters: [Character] = []
    
    init(){}
    
    func fetchFavorites(characterIds: [FavoriteCharacterID]) async {
        if !characterIds.isEmpty {
            let service = Service(urlSession: URLSession.shared)
            do {
                let response = try await service.fetchFavoritesCharacters(ids: characterIds.map { $0.id })
                self.favoritesCharacters = response
            } catch {
                print("Failed to fetch characters")
            }
        }
    }
}
