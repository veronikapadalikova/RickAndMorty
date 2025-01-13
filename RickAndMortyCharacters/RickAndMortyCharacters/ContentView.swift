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
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Group {
                switch selectedTab {
                case 0:
                    AllCharactersView()
                case 1:
                    FavoritesCharactersView()
                default:
                    Text("Unknown Tab")
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
            
            ZStack {
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

#Preview {
    ContentView()
}
