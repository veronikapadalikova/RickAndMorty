//
//  AllCharactersView.swift
//  RickAndMortyCharacters
//
//  Created by Veronika Padalíková on 11.01.2025.
//

import SwiftUI
import SwiftData

struct AllCharactersView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var characterIds: [FavoriteCharacterID]
    
    @ObservedObject private var viewModel = AllCharactersViewModel()
    
    var body: some View {
        StyledNavigationStack {
            VStack {
                List {
                    SearchBar(text: $viewModel.searchText, onTextDelete: viewModel.cancelSearch)
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color(.backgroundsPrimary))
                        .listRowInsets(EdgeInsets(top: 16, leading: 16, bottom: 24, trailing: 16))
                    
                    ForEach(Array(viewModel.characters), id: \.self) { character in
                        CharacterCard(character: character)
                            .overlay(content: {
                                NavigationLink(destination: CharacterDetail(character: character, previousViewTitle: "Characters"), label: {
                                    EmptyView()
                                })
                                .opacity(0)
                            })
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color(.backgroundsPrimary))
                            .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                    }
                    if viewModel.moreCharacters != nil && !viewModel.characters.isEmpty {
                        PagingRow(
                            paginationState: viewModel.paginationState,
                            fetchMoreCharacters: {
                                Task {
                                    await viewModel.fetchMoreCharacters()
                                }
                            })
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color(.backgroundsPrimary))
                    } else {
                        Rectangle()
                            .fill(.backgroundsPrimary)
                            .frame(height: 60)
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color(.backgroundsPrimary))
                    }
                }
                .listStyle(.plain)
                .background(.backgroundsPrimary)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Characters")
                        .fontStyle(Typography.heading1)
                        .foregroundStyle(.foregroundsPrimary)
                        .padding(.top, 8)
                        .padding(.bottom, 10)
                }
            }
        }
    }
}

#Preview {
    AllCharactersView()
}
