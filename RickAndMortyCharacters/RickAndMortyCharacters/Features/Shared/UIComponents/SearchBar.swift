//
//  SearchBar.swift
//  RickAndMortyCharacters
//
//  Created by Veronika Padalíková on 12.01.2025.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    @FocusState private var isFieldFocused: Bool
    var onCancel: () -> Void
    
    var body: some View {
        HStack(spacing: 8) {
            HStack {
                Image("search")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                    .foregroundStyle(.iconsPrimary)
                    .padding(.leading, 8)
                
                TextField("", text: $text, prompt: Text("Search character").foregroundStyle(.foregroundsSecondary))
                    .focused($isFieldFocused)
                    .font(Typography.paragraphMedium.font)
                    .foregroundStyle(.foregroundsPrimary)
                    .accentColor(.foregroundsPrimary)
                    .padding(.vertical, 8)
                
                if !text.isEmpty {
                    Image("x-circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 16, height: 16)
                        .foregroundStyle(.iconsPrimary)
                        .padding(.trailing, 8)
                        .onTapGesture {
                            text = ""
                            onCancel()
                        }
                }
            }
            .background(.backgroundsSecondary)
            .cornerRadius(16)
            .frame(height: 32)
            
            if isFieldFocused {
                Button(action: {
                    withAnimation {
                        isFieldFocused = false
                    }
                }) {
                    Text("Cancel")
                        .fontStyle(Typography.paragraphMedium)
                        .foregroundStyle(.foregroundsPrimary)
                }
                .transition(.move(edge: .trailing).combined(with: .opacity))
                .animation(.easeInOut(duration: 0.25), value: isFieldFocused)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    struct Preview: View {
        @State var text = "rick"
        
        var body: some View {
            SearchBar(text: $text, onCancel: { return })
        }
    }
    
    return Preview()
}
