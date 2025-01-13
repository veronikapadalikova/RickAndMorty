//
//  ContentViewExtension.swift
//  RickAndMortyCharacters
//
//  Created by Veronika Padalíková on 11.01.2025.
//

import SwiftUI

extension ContentView {
    
    func customTabItem(imageName: String, isActive: Bool) -> some View {
        Image(imageName)
            .resizable()
            .foregroundStyle(Color(isActive ? .accentPrimary : .iconsSecondary))
            .frame(width: 42, height: 42)
    }
}
