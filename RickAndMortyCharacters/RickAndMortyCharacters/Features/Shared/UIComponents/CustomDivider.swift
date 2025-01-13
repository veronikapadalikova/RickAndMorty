//
//  CustomDivider.swift
//  RickAndMortyCharacters
//
//  Created by Veronika Padalíková on 12.01.2025.
//

import SwiftUI

struct CustomDivider: View {
    
    var body: some View {
       Rectangle()
            .fill(.foregroundsSeparator)
            .frame(height: 1)
            .edgesIgnoringSafeArea(.horizontal)
    }
}

#Preview {
    CustomDivider()
}
