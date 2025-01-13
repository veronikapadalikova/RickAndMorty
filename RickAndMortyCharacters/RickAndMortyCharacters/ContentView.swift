//
//  ContentView.swift
//  RickAndMortyCharacters
//
//  Created by Veronika Padalíková on 11.01.2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var selectedTab = 0
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        StyledNavigationStack {
            ZStack(alignment: .bottom) {
                TabView(selection: $selectedTab) {
                    AllCharactersView()
                        .tag(0)
                    
                    FavoritesCharactersView()
                        .tag(1)
                }
                
                HStack {
                    HStack(spacing: 32) {
                        ForEach(TabbedItems.allCases, id: \.self) { item in
                            Button(action: {
                                selectedTab = item.rawValue
                            }) {
                                customTabItem(imageName: item.iconName, isActive: (selectedTab == item.rawValue))
                            }
                        }
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 32)
                }
                .background(.backgroundsBottomNavigation)
                .clipShape(RoundedRectangle(cornerRadius: 31))
                .shadow(color: .black.opacity(0.16), radius: 16, x: 0, y: 2)
                .padding(.horizontal)
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
        }
    }
}

#Preview {
    ContentView()
}
