//
//  ContentView.swift
//  HighRoller
//
//  Created by Akash Bhardwaj on 2023-12-22.
//

import SwiftUI

struct ContentView: View {
    let timer = Timer.publish(every: 0.3, on: .main, in: .common).autoconnect()
    @StateObject private var viewModel = ViewModel()

    var body: some View {
        List {
            Text("Total Rolled till now: \(viewModel.totalRolled)")
                .font(.title)
            Section("Dice sides: \(viewModel.diceSide)") {
                Stepper("Number of sides: \(viewModel.diceSide)", value: $viewModel.diceSide, in: 1...100, step: Int.Stride(2.0))

                Button("Roll") {
                    viewModel.rollDice()
                }
                .accessibilityHint("Tap to roll the dice")
            }

            Text("\(viewModel.dice)")
                .font(.largeTitle)
                .foregroundStyle(.red)
                .multilineTextAlignment(.center)
                .accessibilityLabel("Rolled \(viewModel.dice)")
                .accessibilityHint("Roll the dice to increase the total")

            Section("Previous Rolls") {
                ForEach(viewModel.previousRolls, id: \.self) { roll in
                    Text("\(roll)")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
            .accessibilityHint("Previously rolled numbers")

        }
        .sensoryFeedback(.increase, trigger: viewModel.dice)
        .onReceive(timer) { _ in
            viewModel.timeClick()
        }
    }
}

#Preview {
    ContentView()
}
