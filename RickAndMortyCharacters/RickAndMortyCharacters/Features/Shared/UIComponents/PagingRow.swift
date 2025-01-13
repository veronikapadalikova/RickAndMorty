//
//  PagingRow.swift
//  RickAndMortyCharacters
//
//  Created by Veronika Padalíková on 13.01.2025.
//

import SwiftUI

struct PagingRow: View {
    let paginationState: PaginationState?
    let fetchMoreCharacters: () -> Void
    
    var body: some View {
        ZStack(alignment: .center) {
            switch paginationState {
            case .loading:
                HStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
                .background(.backgroundsPrimary)
            case .idle:
                Rectangle()
                    .fill(.backgroundsPrimary)
            case .error:
                HStack(spacing: 4) {
                    Spacer()
                    
                    Image(systemName: "person.fill.questionmark")
                        .imageScale(.large)
                        .foregroundStyle(.iconsSecondary)
                        .background(.backgroundsPrimary)
                    
                    Text("Failed to load more")
                        .fontStyle(Typography.paragraphSmall)
                        .foregroundStyle(.foregroundsSecondary)
                    
                    // some reload button would be nice here
                    Spacer()
                }
            case .none:
                Rectangle()
                    .fill(.backgroundsPrimary)
            }
        }
        .frame(height: 60)
        .padding(.bottom, 72)
        .onAppear {
            Task {
                self.fetchMoreCharacters()
            }
        }
    }
}
