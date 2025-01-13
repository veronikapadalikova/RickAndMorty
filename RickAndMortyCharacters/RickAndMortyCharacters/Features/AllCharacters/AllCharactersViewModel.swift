//
//  AllCharactersViewModel.swift
//  RickAndMortyCharacters
//
//  Created by Veronika Padalíková on 12.01.2025.
//

import Foundation
import Combine

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
    @Published var searchText: String = ""
    
    var moreCharacters: String?
    var paginationState: PaginationState?
    
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        $searchText
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] text in
                self?.performSearch(query: text)
            }
            .store(in: &cancellables)
        
        Task {
            await self.fetchCharacters()
        }
    }
    
    func fetchCharacters() async {
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
    
    func performSearch(query: String) {
        guard !query.isEmpty else {
            return
        }
        
        Task {
            let service = Service(urlSession: URLSession.shared)
            do {
                let response = try await service.fetchSearchedCharacter(name: query)
                DispatchQueue.main.async {
                    self.moreCharacters = response.info.next
                    self.characters = response.results
                }
            } catch {
                // TODO: show alert
                print("Failed to fetch searched characters, error: \(error)")
            }
        }
    }
    
    func cancelSearch() {
        Task {
            await self.fetchCharacters()
        }
    }
    
    func fetchMoreCharacters() async {
        self.paginationState = .loading
        if let apiUrl = URL(string: self.moreCharacters ?? "") {
            URLSession.shared.dataTask(with: apiUrl) { [weak self] data, response, error in
                if error != nil {
                    DispatchQueue.main.async {
                        self?.paginationState = .error
                    }
                    return
                }
                
                guard let data = data else {
                    DispatchQueue.main.async {
                        self?.paginationState = .error
                    }
                    return
                }
                
                do {
                    let decodedResponse = try JSONDecoder().decode(CharacterResponse.self, from: data)
                    DispatchQueue.main.async {
                        self?.characters += decodedResponse.results
                        self?.moreCharacters = decodedResponse.info.next
                        self?.paginationState = .idle
                    }
                } catch {
                    DispatchQueue.main.async {
                        self?.paginationState = .error
                    }
                }
            }.resume()
        } else {
            DispatchQueue.main.async {
                self.paginationState = .error
            }
        }
    }
}
