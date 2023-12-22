//
//  ContentView-ViewModel.swift
//  HighRoller
//
//  Created by Akash Bhardwaj on 2023-12-22.
//

import Foundation
struct SavedData: Codable {
    let diceSides: Int
    let total: Int
    let previousRolls: [Int]
}
extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        @Published var diceSide = 4
        @Published private(set) var totalRolled = 0
        @Published private(set) var dice = 1
        var diceValues: [Int] {
            Array(1...Int(diceSide))
        }
        @Published private(set) var timeRemaining = 6
        @Published private(set) var isDiceRolling = false
        @Published private(set) var previousRolls = [Int]()

        init() {
            if let data = try? Data(contentsOf: savedPath) {
                if let decoded = try? JSONDecoder().decode(SavedData.self, from: data) {
                    diceSide = decoded.diceSides
                    totalRolled = decoded.total
                    previousRolls = decoded.previousRolls
                }
            }
        }

        func rollDice() {
            isDiceRolling = true
        }

        func timeClick() {
            if isDiceRolling {
                if timeRemaining > 0 {
                    timeRemaining -= 1
                    dice = diceValues.randomElement() ?? 1

                }
            }
            if timeRemaining == 0 {
                stopDice()
                return
            }
        }

        private func stopDice() {
            isDiceRolling = false
            timeRemaining = 4
            totalRolled += dice
            previousRolls.append(Int(dice))
            save()
        }

        private var dataToSave: SavedData {
            return SavedData(diceSides: diceSide, total: totalRolled, previousRolls: previousRolls)
        }

        private let savedPath = FileManager.documentDirectory.appendingPathComponent("SavedData")
        private func save() {
            if let encoded = try? JSONEncoder().encode(dataToSave) {
                try? encoded.write(to: savedPath)
            }
        }
    }
}

extension FileManager {
    static var documentDirectory: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
