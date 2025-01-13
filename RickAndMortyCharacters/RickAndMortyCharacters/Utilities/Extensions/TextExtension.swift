//
//  TextExtension.swift
//  RickAndMortyCharacters
//
//  Created by Veronika Padalíková on 11.01.2025.
//

import SwiftUI

extension Text {
    
    func fontStyle(_ style: FontStyle) -> some View {
        self.font(style.font)
            .lineSpacing(style.lineHeight - style.size)
            .fontWeight(style.weight)
            .multilineTextAlignment(style.alignment)
    }
}
