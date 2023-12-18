//
//  ContentView.swift
//  FlashZilla
//
//  Created by Akash Bhardwaj on 2023-12-17.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        NavigationView {
            List {
                NavigationLink("Timer", destination: TimerView())
                NavigationLink("AppLifeCycle", destination: AppLifeCycleView())
                NavigationLink("Accessibility", destination: AccessibilityView())
            }
            .navigationTitle("flashzilla")
        }
    }
}

#Preview {
    ContentView()
}

struct TimerView: View {
    let timer = Timer.publish(every: 1, tolerance: 0.5, on: .main, in: .common).autoconnect()

    @State private var counter = 0

    var body: some View {
        Text("Hello, World!")
            .onReceive(timer) { time in
                if counter == 5 {
                    timer.upstream.connect().cancel()
                } else {
                    print("The time is now \(time)")
                }
                counter += 1
            }
    }
}
