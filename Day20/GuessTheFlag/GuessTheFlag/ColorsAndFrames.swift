//
//  ColorsAndFrames.swift
//  GuessTheFlag
//
//  Created by Akash Bhardwaj on 2023-08-04.
//

import SwiftUI

struct ColorsAndFrames: View {
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Color.red
                Color.blue
            }
            Text("Right Here")
                .foregroundStyle(.secondary)
                .padding(50)
                .background(.ultraThinMaterial)
        }
        .ignoresSafeArea()

    }
}

struct ColorsAndFrames_Previews: PreviewProvider {
    static var previews: some View {
        ColorsAndFrames()
    }
}
