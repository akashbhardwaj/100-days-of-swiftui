//
//  Gradients.swift
//  GuessTheFlag
//
//  Created by Akash Bhardwaj on 2023-08-04.
//

import SwiftUI

struct Gradients: View {
    var body: some View {
        VStack(spacing: 0) {
            LinearGradient(gradient:
                    Gradient(stops:[
                        .init(color: .red, location: 0.30),
                        .init(color: .green, location: 0.70)
                    ]), startPoint: .leading, endPoint: .trailing)

            RadialGradient(gradient: Gradient(colors: [
                .red, .black]), center: .center, startRadius: 20, endRadius: 200)

            AngularGradient(colors: [.indigo, .blue, .green, .yellow, .orange, .red, .indigo], center: .center)
        }
        .ignoresSafeArea()
    }
}

struct Gradients_Previews: PreviewProvider {
    static var previews: some View {
        Gradients()
    }
}
