//
//  FavoriteCharacter.swift
//  RickAndMortyCharacters
//
//  Created by Veronika Padalíková on 11.01.2025.
//

import Foundation
import SwiftData

@Model
final class FavoriteCharacterID {
    var id: Int
    
    init(id: Int) {
        self.id = id
    }
}
