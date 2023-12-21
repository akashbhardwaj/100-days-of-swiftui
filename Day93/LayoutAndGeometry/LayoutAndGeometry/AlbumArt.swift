//
//  AlbumArt.swift
//  LayoutAndGeometry
//
//  Created by Akash Bhardwaj on 2023-12-21.
//

import SwiftUI

struct AlbumArt: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(0..<20) { num in
                    GeometryReader { geo in
                        Text("Number \(num)")
                            .font(.largeTitle)
                            .padding()
                            .background(.red)
                            .rotation3DEffect(
                                .degrees(-geo.frame(in: .global).minX) / 8,
                                axis: (x: 0.0, y: 1.0, z: 0.0)
                            )
                            .frame(width: 200, height: 200)
                    }
                    .frame(width: 200, height: 200)
                }
            }
        }
    }
}

#Preview {
    AlbumArt()
}
