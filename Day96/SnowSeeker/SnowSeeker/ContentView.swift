//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Akash Bhardwaj on 2023-12-27.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            NavigationLink {
                Text("New Secondary")
            } label: {
                Text("Hello, world!")
            }
            .navigationTitle("Primary")
            .padding()
            Text("Secondary")

            Text("Tertiary")
        }
    }
}

#Preview {
    ContentView()
}
