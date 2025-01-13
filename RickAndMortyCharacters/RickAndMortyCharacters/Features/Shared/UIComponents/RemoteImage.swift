//
//  RemoteImage.swift
//  RickAndMortyCharacters
//
//  Created by Veronika Padalíková on 13.01.2025.
//

import SwiftUI

struct RemoteImage: View {
    let url: String
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        AsyncImage(url: URL(string: url)) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else if phase.error != nil {
                Image(systemName: "person.fill.questionmark")
                    .imageScale(.large)
            } else {
                ProgressView()
            }
        }
        .frame(width: width, height: height)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
