//
//  Favourites.swift
//  SnowSeeker
//
//  Created by Akash Bhardwaj on 2023-12-29.
//

import Foundation
class Favourites: ObservableObject {
    private var resorts: Set<String>
    private let savedPath = FileManager.documentsDirectory.appendingPathComponent("Favourites")

    init() {
        if let savedData = try? Data(contentsOf: savedPath) {
            if let decoded = try? JSONDecoder().decode(Set<String>.self, from: savedData) {
                self.resorts = decoded
            } else {
                self.resorts = []
            }
        } else {
            self.resorts = []
        }
    }

    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }

    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }

    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }

    func save() {
        if let data = try? JSONEncoder().encode(resorts) {
            try? data.write(to: savedPath)
        }
    }
}
extension FileManager {
    static var documentsDirectory: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
