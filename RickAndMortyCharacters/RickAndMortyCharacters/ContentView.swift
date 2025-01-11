//
//  ContentView.swift
//  RickAndMortyCharacters
//
//  Created by Veronika Padalíková on 11.01.2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State var selectedTab = 0
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                AllCharactersView()
                    .tag(0)
                
                FavoritesCharactersView()
                    .tag(1)
            }
        }
        
        ZStack {
            HStack(spacing: 32) {
                ForEach((TabbedItems.allCases), id: \.self) { item in
                    Button {
                        self.selectedTab = item.rawValue
                    } label: {
                        customTabItem(imageName: item.iconName, isActive: (self.selectedTab == item.rawValue))
                    }
                }
            }
            .padding(.vertical, 10.0)
            .padding(.horizontal, 32.0)
        }
        .background(.backgroundsBottomNavigation)
        .clipShape(RoundedRectangle(cornerRadius: 31))
        .shadow(radius: 12)
    }
}

#Preview {
    ContentView()
}
