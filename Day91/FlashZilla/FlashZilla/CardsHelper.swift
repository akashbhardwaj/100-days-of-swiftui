//
//  CardsHelper.swift
//  FlashZilla
//
//  Created by Akash Bhardwaj on 2023-12-20.
//

import Foundation
struct CardsHelper {
    static let savedDirectoryPath = FileManager.documentDirectory.appendingPathComponent("Cards")

    static func getCards() -> [Card] {
        if let data = try? Data(contentsOf: savedDirectoryPath) {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                return decoded
            }
        }
        return []
    }

    static func save(cards: [Card]) {
        if let data = try? JSONEncoder().encode(cards) {
            try? data.write(to: savedDirectoryPath)
        }
    }
}
