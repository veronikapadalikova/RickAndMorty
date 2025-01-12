//
//  CharacterDetail.swift
//  RickAndMortyCharacters
//
//  Created by Veronika Padalíková on 12.01.2025.
//

import SwiftUI

struct CharacterDetail: View {
    @Environment(\.dismiss) var dismiss
    
    var character: Character
    var previousViewTitle: String
    
    var body: some View {
        ZStack {
            Color(.backgroundsPrimary)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                VStack(spacing: 0) {
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
                        .frame(width: 140, height: 140)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        
                        VStack(alignment: .leading, spacing: 6) {
                            HStack(alignment: .top) {
                                Text("Name")
                                    .fontStyle(Typography.paragraphMedium)
                                    .foregroundStyle(.foregroundsSecondary)
                                Spacer()
                                // TODO: add condition for favorites
                                Image("favorites_inactive_32px") // or favorites_active_32px
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 32, height: 32)
                                    .foregroundStyle(.iconsSecondary)
                            }
                            
                            Text(character.name)
                                .fontStyle(Typography.heading2)
                                .foregroundStyle(.foregroundsPrimary)
                        }
                    }
                    .padding(16)
                    
                    CustomDivider()
                    
                    HStack {
                        CharacterDetailInfo(character: self.character)
                        Spacer()
                    }
                        .padding(24)
                }
                .background(.backgroundsTertiary)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .shadow(color: .black.opacity(0.04), radius: 16)
                .padding(.horizontal, 16)
                
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    self.dismiss()
                } label: {
                    HStack(alignment: .center, spacing: 8) {
                        Image("chevron_left_24px")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24, height: 24)
                            .foregroundStyle(.iconsPrimary)
                        
                        Text(self.previousViewTitle)
                            .fontStyle(Typography.paragraphMedium)
                            .foregroundStyle(.foregroundsPrimary)
                    }
                }
                .padding(.top, 8)
                .padding(.bottom, 10)
            }
        }
    }
}

#Preview {
    CharacterDetail(character: Character.sample, previousViewTitle: "Characters")
}
