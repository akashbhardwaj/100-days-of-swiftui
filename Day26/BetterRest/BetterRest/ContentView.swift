//
//  ContentView.swift
//  BetterRest
//
//  Created by Akash Bhardwaj on 2023-08-16.
//

import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 0.0
    @State private var wakeUp = Date.now
    var body: some View {
        Form {
            Section {
                Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
            }

            Section {
                DatePicker("Please enter a date", selection: $wakeUp, in: Date.now...)
            }

            Section {
                Text(wakeUp, format: .dateTime
                    .hour()
                    .minute()
                    .year()
                    .month()
                    .day())
            }
        }
    }

    func dateCalculations() {
        var components = DateComponents()
        components.hour = 8
        components.minute = 0
        let date = Calendar.current.date(from: components) ?? Date.now

        func dd() {
            var components = Calendar.current.dateComponents([.hour, .minute], from: Date.now)
            let hour = components.hour ?? 0
            let minute = components.hour ?? 0
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
