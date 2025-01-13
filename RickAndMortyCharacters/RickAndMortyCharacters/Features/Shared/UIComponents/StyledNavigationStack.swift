//
//  StyledNavigationStack.swift
//  RickAndMortyCharacters
//
//  Created by Veronika Padalíková on 13.01.2025.
//

import SwiftUI

struct StyledNavigationStack<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.backgroundsPrimary)
                    .edgesIgnoringSafeArea(.all)
                
                content
            }
            .onAppear {
                self.configureNavigationBarApperance()
            }
        }
    }
    
    private func configureNavigationBarApperance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(Color(.backgroundsPrimary))
        appearance.shadowColor = .clear
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}
