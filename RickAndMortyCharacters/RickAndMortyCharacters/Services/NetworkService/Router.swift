//
//  Router.swift
//  RickAndMortyCharacters
//
//  Created by Veronika Padalíková on 11.01.2025.
//
import Foundation

protocol URLRequestCovertible {
    func makeURLRequest() throws -> URLRequest
}

enum Router: URLRequestCovertible {
    case fetchAllCharacters
    case searchCharacter(name: String)
    case fetchCharacterDetail(id: Int)
    case fetchSpecificCharacters(ids: [Int])
    
    var endpoint: String {
        switch self {
        case .fetchAllCharacters:
            return "/character"
        case .searchCharacter:
            return "/character"
        case .fetchCharacterDetail(let id):
            return "/character/\(id)"
        case .fetchSpecificCharacters(let ids):
            return "/character/\(ids)"
        }
    }
    
    var query: String? {
        switch self {
        case .searchCharacter(let name):
            return "/?name=\(name)"
        default:
            return nil
        }
    }
    
    var method: String {
        return "GET"
    }
    
    func makeURLRequest() throws -> URLRequest {
        guard let url = URL(string: APIConfig.baseURL + endpoint) else {
            throw NetworkError.invalidUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = self.method
        
        return request
    }
}
