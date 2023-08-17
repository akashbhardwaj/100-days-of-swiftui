//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Akash Bhardwaj on 2023-08-04.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            Form {
                NavigationLink("Stacks", destination: Stacks())
                NavigationLink("ColorsAndFrames", destination: ColorsAndFrames())
                NavigationLink("Gradients", destination: Gradients())
                NavigationLink("Buttons and Images", destination: ButtonsAndImages())
                NavigationLink("Alerts", destination: Alerts())

            }
            .navigationTitle("Day20")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Stacks: View {
    var body: some View {
        VStack {
            ForEach(0..<3) { _ in
                HStack {
                    ForEach(0..<3) { _ in
                        Image(systemName: "globe")
                            .imageScale(.large)
                            .foregroundColor(.accentColor)
                    }
                }
            }
        }
    }
}
