//
//  AstronautView.swift
//  Moonshot
//
//  Created by Akash Bhardwaj on 2023-09-18.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut

    var body: some View {
        ScrollView {
            VStack {
                Image(decorative: astronaut.id)
                    .resizable()
                    .scaledToFit()

                Text(astronaut.description)
                    .foregroundColor(.white)
                    .padding()
            }
        }
        .background(.darkBackground)
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    static var previews: some View {
        AstronautView(astronaut: astronauts["armstrong"]!)
    }
}