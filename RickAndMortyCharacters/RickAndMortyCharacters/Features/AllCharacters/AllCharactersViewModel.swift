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

enum PaginationState {
    case loading
    case idle
    case error
}

@MainActor
class AllCharactersViewModel: ObservableObject, @preconcurrency CharacterViewModel {
    @Published var characters: [Character] = []
    
    var moreCharacters: String?
    var paginationState: PaginationState?
    
    init(){}
    
    func fetchCharacters() async {
        if self.characters.isEmpty {
            let service = Service(urlSession: URLSession.shared)
            do {
                let response = try await service.fetchAllCharacters(page: nil)
                self.moreCharacters = response.info.next
                self.characters = response.results
            } catch {
                // TODO: show alert
                print("Failed to fetch characters")
            }
        }
    }
    
    func fetchMoreCharacters() async {
        self.paginationState = .loading
        guard let page = self.extractPageNumber() else {
            self.paginationState = .error
            return
        }
        let service = Service(urlSession: URLSession.shared)
        do {
            let response = try await service.fetchAllCharacters(page: page)
            self.moreCharacters = response.info.next
            self.characters += response.results
            self.paginationState = .idle
        } catch {
            self.paginationState = .error
            print("Failed to fetch characters")
        }
    }
    
    func extractPageNumber() -> Int? {
        guard let input = self.moreCharacters,
              let lastCharacter = input.last,
              let number = Int(String(lastCharacter)) else {
            return nil
        }
        return number
    }
}
