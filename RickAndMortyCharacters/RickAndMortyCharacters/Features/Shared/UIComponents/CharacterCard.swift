//
//  CharacterCard.swift
//  RickAndMortyCharacters
//
//  Created by Veronika Padalíková on 11.01.2025.
//

import SwiftUI

struct CharacterCard: View {
    
    let character: Character
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            AsyncImage(url: URL(string: self.character.image)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } else if phase.error != nil {
                    Image(systemName: "questionmark.diamond")
                        .imageScale(.large)
                } else {
                    ProgressView()
                }
            }
            .frame(width: 44, height: 44)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            
            VStack(alignment: .leading) {
                HStack(alignment: .top, spacing: 4) {
                    Text(self.character.name)
                        .fontStyle(Typography.heading3)
                        .foregroundStyle(Color(.foregroundsPrimary))
                    
                    // TODO: add condition for favorites
                    Image("favorites_active")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 16, height: 16)
                        .foregroundStyle(Color(.accentPrimary))
                        .padding(.vertical, 2)
                }
                
                Text(self.character.status.rawValue)
                    .fontStyle(Typography.paragraphSmall)
                    .foregroundStyle(Color(.foregroundsSecondary))
            }
            
            Spacer()
            
            Image("chevron_left_24px")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .fontWeight(.regular)
                .frame(width: 24, height: 24)
                .foregroundStyle(Color(.iconsSecondary))
                .padding(.top, 10)
        }
        .padding(8)
        .background(.backgroundsTertiary)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.04), radius: 16)
        
    }
}

#Preview {
    CharacterCard(character: Character.sample)
}
