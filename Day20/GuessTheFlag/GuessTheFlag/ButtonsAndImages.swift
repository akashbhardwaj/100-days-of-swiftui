//
//  ButtonsAndImages.swift
//  GuessTheFlag
//
//  Created by Akash Bhardwaj on 2023-08-04.
//

import SwiftUI

struct ButtonsAndImages: View {
    var body: some View {
        VStack {
            Button("Button 1") { }
                .buttonStyle(.bordered)
            Button("Button 2", role: .destructive) { }
                .buttonStyle(.bordered)
            Button("Button 3") { }
                .buttonStyle(.borderedProminent)
            Button("Button 4", role: .destructive) { }
                .buttonStyle(.borderedProminent)

            Button {

            } label: {
                Text("Tap!")
                    .padding()
                    .foregroundStyle(.white)
                    .background(.primary)
            }

            Button {

            } label: {
                Image(systemName: "pencil")
                    .renderingMode(.original)
                    .padding()
                    .background(.red)
            }

            Button {

            } label: {
                Label("Write", systemImage: "pencil")
            }
            .buttonStyle(.bordered)

        }

    }
}

struct ButtonsAndImages_Previews: PreviewProvider {
    static var previews: some View {
        ButtonsAndImages()
    }
}
