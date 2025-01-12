//
//  AllCharactersView.swift
//  RickAndMortyCharacters
//
//  Created by Veronika Padalíková on 11.01.2025.
//

import SwiftUI

struct AllCharactersView: View {
    
    @ObservedObject private var viewModel = AllCharactersViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.backgroundsPrimary)
                    .edgesIgnoringSafeArea(.all)
                
                // TODO: add search bar that is hidable and custom
                List {
                    ForEach(Array(viewModel.characters.enumerated()), id: \.1.self) { index, character in
                        CharacterCard(character: character)
                            .overlay(content: {
                                NavigationLink(destination: CharacterDetail(character: character, previousViewTitle: "Characters"), label: {
                                    EmptyView()
                                })
                                .opacity(0)
                            })
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color(.backgroundsPrimary))
                            .padding(.bottom, index == viewModel.characters.count - 1 ? 72 : 0)
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
                Task {
                    await viewModel.fetchCharacters()
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
    AllCharactersView()
}
