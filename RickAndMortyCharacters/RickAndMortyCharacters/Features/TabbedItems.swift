//
//  TabbedItems.swift
//  RickAndMortyCharacters
//
//  Created by Veronika Padalíková on 11.01.2025.
//

enum TabbedItems: Int, CaseIterable {
    case allCharacters
    case favoritesCharaters
    
    var iconName: String {
        switch self {
        case .allCharacters:
            return "characters"
        case .favoritesCharaters:
            return "favorites_inactive"
        }
    }
}
