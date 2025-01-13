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
    case fetchAllCharacters(page: Int?)
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
    
    var query: URLQueryItem? {
        switch self {
        case .fetchAllCharacters(let page):
            if let page = page {
                return URLQueryItem(name: "page", value: "\(page)")
            } else {
                return nil
            }
        case .searchCharacter(let name):
            return URLQueryItem(name: "name", value: name)
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
        
        if let query = query {
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
            components?.queryItems = [
                query
            ]
            
            guard let finalURL = components?.url else {
                throw NetworkError.invalidUrl
            }
            
            var request = URLRequest(url: finalURL)
            request.httpMethod = self.method
            return request
        } else {
            var request = URLRequest(url: url)
            request.httpMethod = self.method
            
            return request
        }
    }
}
