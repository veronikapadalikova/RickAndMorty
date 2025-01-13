//
//  NetworkService.swift
//  RickAndMortyCharacters
//
//  Created by Veronika Padalíková on 11.01.2025.
//

import Foundation

class NetworkService<Router: URLRequestCovertible> {
    private let urlSession: URLSession
    
    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
    
    private func handleResponse(data: Data, response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.requestFailed(statusCode: httpResponse.statusCode)
        }
    }
    
    func request<T: Decodable>(_ returnType: T.Type, router: Router) async throws -> T {
        let request = try router.makeURLRequest()
        
        let (data, response) = try await urlSession.data(for: request)
        
        try self.handleResponse(data: data, response: response)
        
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(returnType, from: data)
            return decodedData
        } catch {
            throw NetworkError.dataConversionFailure
        }
    }
}

class Service: NetworkService<Router> {
    
    func fetchAllCharacters(page: Int?) async throws -> CharacterResponse {
        return try await request(CharacterResponse.self, router: .fetchAllCharacters(page: page))
    }
    
    func fetchFavoritesCharacters(ids: [Int]) async throws -> [Character] {
        return try await request([Character].self, router: .fetchSpecificCharacters(ids: ids))
    }
    
    func fetchSearchedCharacter(name: String) async throws -> CharacterResponse {
        return try await request(CharacterResponse.self, router: .searchCharacter(name: name))
    }
}
