//
//  MainContentView.swift
//  CiaoChow
//
//  Created by Tyler Torres on 10/13/24.
//

import SwiftUI

struct MainContentView: View {
    var body: some View {
        List {
            ForEach(0..<27) { _ in
                cell
            }
        }
        .safeAreaInset(edge: .bottom, alignment: .trailing, spacing: 12) {
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.pink.gradient)
                .frame(maxWidth: .infinity, maxHeight: 70)
                .padding()
        }
        .navigationTitle("Recipes")
    }
    
    var cell: some View {
        HStack(alignment: .top, spacing: 12) {
            
            RoundedRectangle(cornerRadius: 12)
                .frame(width: 80, height: 80)
                .foregroundStyle(.blue.gradient.opacity(0.2))
            
            VStack(alignment: .leading) {
                Text("Recipe Title")
                    .font(.headline)
                Text("This would be a short description of the recipe, and potentially a small summary")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            
        }
    }
}

#Preview {
    MainContentView()
}
