//
//  AllCharactersViewModel.swift
//  RickAndMortyCharacters
//
//  Created by Veronika Padalíková on 12.01.2025.
//

import Foundation

protocol CharacterViewModel {
    var characters: [Character] { get set }
    
    func fetchCharacters() async
}

@MainActor
class AllCharactersViewModel: ObservableObject, @preconcurrency CharacterViewModel {
    @Published var characters: [Character] = []
    
    init(){}
    
    func fetchCharacters() async {
        if self.characters.isEmpty {
            let service = Service(urlSession: URLSession.shared)
            do {
                let response = try await service.fetchAllCharacters()
                self.characters = response.results
            } catch {
                // TODO: show alert
                print("Failed to fetch characters")
            }
        }
    }
    
    // TODO: add paging
}
