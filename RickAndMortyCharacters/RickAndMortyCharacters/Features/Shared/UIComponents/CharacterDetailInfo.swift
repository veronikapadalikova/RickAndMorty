//
//  CharacterDetailInfo.swift
//  RickAndMortyCharacters
//
//  Created by Veronika Padalíková on 12.01.2025.
//

import SwiftUI

struct CharacterDetailInfo: View {
    
    var character: Character
    var items: [(key: String, value: String)]
    
    init(character: Character) {
        self.character = character
        self.items = [
            ("Status", character.status.rawValue),
            ("Species", character.species),
            ("Type", character.type),
            ("Gender", character.gender.rawValue),
            ("Origin", character.origin.name),
            ("Location", character.location.name)
        ]
    }
    
    var body: some View {
        Grid(alignment: .leading, horizontalSpacing: 32, verticalSpacing: 24) {
            ForEach(items, id: \.key) { key, value in
                GridRow {
                    Text(key)
                        .fontStyle(Typography.paragraphSmall)
                        .foregroundStyle(.foregroundsSecondary)
                    
                    Text(value == "" ? "-" : value)
                        .fontStyle(Typography.heading3)
                        .foregroundStyle(.foregroundsPrimary)
                }
            }
        }
    }
}

#Preview {
    CharacterDetailInfo(character: Character.sample)
}
