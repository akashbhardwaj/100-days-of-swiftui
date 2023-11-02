//
//  ContentView.swift
//  InstaFilter
//
//  Created by Akash Bhardwaj on 2023-11-02.
//

import SwiftUI

struct ContentView: View {
    @State private var blurAmount = 0.0

    var body: some View {
        VStack {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
            }
            .blur(radius: blurAmount)

            Slider(value: $blurAmount, in: 0...20)

            Button("Random Blur") {
                blurAmount = Double.random(in: 0...20)
            }
        }
        .padding()
        .onChange(of: blurAmount) { _, newValue  in
            print("New value is \(newValue)")
        }

    }
}

#Preview {
    ContentView()
}


struct ConfirmationDialog: View {
    @State private var showingConfirmation = false
    @State private var backgroundColor = Color.white
    var body: some View {
        Text("Hello World!")
            .frame(width: 300, height: 300)
            .background(backgroundColor)
            .onTapGesture {
                showingConfirmation = true
            }
            .confirmationDialog("Change background", isPresented: $showingConfirmation) {
                Button("Red") {
                    backgroundColor = .red
                }
                Button("Green") {
                    backgroundColor = .green
                }
                Button("Yellow") {
                    backgroundColor = .yellow
                }
                Button("Cancel", role: .cancel) {
                }
            } message: {
                Text("Select a new Color")
            }
    }
}

#Preview {
    ConfirmationDialog()
}
