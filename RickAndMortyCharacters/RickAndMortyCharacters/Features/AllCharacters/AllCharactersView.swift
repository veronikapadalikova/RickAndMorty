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
        NavigationStack {
            ZStack {
                Color(.backgroundsPrimary)
                    .edgesIgnoringSafeArea(.all)
                
                List {
                    SearchBar(text: $viewModel.searchText, onCancel: viewModel.cancelSearch)
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color(.backgroundsPrimary))
                    
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
                    }
                    if viewModel.moreCharacters != nil && !viewModel.characters.isEmpty {
                        pagingRowView
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
                .listRowSpacing(0)
                .background(.backgroundsPrimary)
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
            .onAppear {
                let appearance = UINavigationBarAppearance()
                appearance.configureWithOpaqueBackground()
                appearance.backgroundColor = UIColor(Color(.backgroundsPrimary))
                appearance.shadowColor = .clear
                UINavigationBar.appearance().standardAppearance = appearance
                UINavigationBar.appearance().scrollEdgeAppearance = appearance
            }
        }
    }
    
    var pagingRowView: some View {
        ZStack(alignment: .center) {
            switch viewModel.paginationState {
            case .loading:
                HStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
                .background(.backgroundsPrimary)
            case .idle:
                Rectangle()
                    .fill(.backgroundsPrimary)
            case .error:
                HStack(spacing: 4) {
                    Spacer()
                    
                    Image(systemName: "questionmark.diamond")
                        .imageScale(.large)
                        .foregroundStyle(.iconsSecondary)
                        .background(.backgroundsPrimary)
                    
                    Text("Failed to load more")
                        .fontStyle(Typography.paragraphSmall)
                        .foregroundStyle(.foregroundsSecondary)
                    
                    // some reload button would be nice here
                    Spacer()
                }
            case .none:
                Rectangle()
                    .fill(.backgroundsPrimary)
            }
        }
        .frame(height: 60)
        .padding(.bottom, 72)
        .onAppear {
            Task {
                await viewModel.fetchMoreCharacters()
            }
        }
    }
}

#Preview {
    AllCharactersView()
}
