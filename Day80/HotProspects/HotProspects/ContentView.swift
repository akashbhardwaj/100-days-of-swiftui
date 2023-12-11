//
//  ContentView.swift
//  HotProspects
//
//  Created by Akash Bhardwaj on 2023-12-07.
//

import SwiftUI

@MainActor class DelayedUpdater: ObservableObject {
    var value = 0 {
        willSet {
            objectWillChange.send()
        }
    }

    init() {
        for i in 1...10 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                self.value += 1
            }
        }
    }
}

struct ContentView: View {
    @StateObject private var updater = DelayedUpdater()

    var body: some View {
        VStack {
            Text("Value is \(updater.value)")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
