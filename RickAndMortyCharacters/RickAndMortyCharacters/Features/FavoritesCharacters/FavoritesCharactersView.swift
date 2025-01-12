//
//  FavoritesCharactersView.swift
//  RickAndMortyCharacters
//
//  Created by Veronika Padalíková on 11.01.2025.
//

import SwiftUI
import SwiftData

struct FavoritesCharactersView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var characterIds: [FavoriteCharacterID]
    
    @ObservedObject private var viewModel = FavoritesCharactersViewModel()
    
    var body: some View {
        // TODO: make navigation stack as component
        NavigationStack {
            ZStack {
                Color(.backgroundsPrimary)
                    .ignoresSafeArea(.all)
                
                if self.characterIds.isEmpty {
                    Text("No favorites yet")
                        .fontStyle(Typography.paragraphLarge)
                        .foregroundStyle(.foregroundsTertiary)
                } else {
                    List {
                        ForEach(Array(viewModel.favoritesCharacters.enumerated()), id: \.1.self) { index, character in
                            CharacterCard(character: character)
                                .overlay(content: {
                                    NavigationLink(destination: CharacterDetail(character: character, previousViewTitle: "Favorites"), label: {
                                        EmptyView()
                                    })
                                    .opacity(0)
                                })
                                .listRowSeparator(.hidden)
                                .listRowBackground(Color(.backgroundsPrimary))
                                .padding(.bottom, index == viewModel.favoritesCharacters.count - 1 ? 72 : 0)
                        }
                    }
                    .listStyle(.plain)
                    .listRowSpacing(0)
                    .background(.backgroundsPrimary)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Favorites")
                        .fontStyle(Typography.heading1)
                        .foregroundStyle(.foregroundsPrimary)
                        .padding(.top, 8)
                        .padding(.bottom, 10)
                }
            }
            .onAppear {
                Task {
                    await viewModel.fetchFavorites(characterIds: self.characterIds)
                }
                
                let appearance = UINavigationBarAppearance()
                appearance.configureWithOpaqueBackground()
                appearance.backgroundColor = UIColor(Color(.backgroundsPrimary))
                appearance.shadowColor = .clear
                UINavigationBar.appearance().standardAppearance = appearance
                UINavigationBar.appearance().scrollEdgeAppearance = appearance
            }
        }
    }
}

#Preview {
    FavoritesCharactersView()
}
