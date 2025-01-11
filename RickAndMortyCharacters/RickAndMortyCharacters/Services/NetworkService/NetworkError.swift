//
//  NetworkError.swift
//  RickAndMortyCharacters
//
//  Created by Veronika Padalíková on 11.01.2025.
//

enum NetworkError: Error {
    case invalidUrl
    case requestFailed(statusCode: Int)
    case invalidResponse
    case dataConversionFailure
}
