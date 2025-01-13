//
//  FontStyle.swift
//  RickAndMortyCharacters
//
//  Created by Veronika Padalíková on 11.01.2025.
//

import SwiftUI

struct FontStyle {
    let font: Font
    let size: CGFloat
    let lineHeight: CGFloat
    let weight: Font.Weight
    let alignment: TextAlignment
    
    init(font: Font, size: CGFloat, lineHeight: CGFloat, weight: Font.Weight, alignment: TextAlignment) {
        self.font = font
        self.size = size
        self.lineHeight = lineHeight
        self.weight = weight
        self.alignment = alignment
    }
}
