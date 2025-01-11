//
//  Typography.swift
//  RickAndMortyCharacters
//
//  Created by Veronika Padalíková on 11.01.2025.
//

import SwiftUI

struct Typography {
    
    static let heading1 = FontStyle(font: Font.custom("Inter-Bold", size: 28), size: 28, lineHeight: 34, weight: .bold, alignment: .leading)
    static let heading2 = FontStyle(font: Font.custom("Inter-Bold", size: 20), size: 20, lineHeight: 24, weight: .bold, alignment: .leading)
    static let heading3 = FontStyle(font: Font.custom("Inter-Bold", size: 16), size: 16, lineHeight: 20, weight: .bold, alignment: .leading)
    
    static let paragraphLarge = FontStyle(font: Font.custom("Inter", size: 18), size: 18, lineHeight: 22, weight: .regular, alignment: .center)
    static let paragraphMedium = FontStyle(font: Font.custom("Inter", size: 16), size: 16, lineHeight: 20, weight: .regular, alignment: .leading)
    static let paragraphSmall = FontStyle(font: Font.custom("Inter", size: 14), size: 14, lineHeight: 18, weight: .regular, alignment: .leading)
}
