//
//  Favourites.swift
//  SnowSeeker
//
//  Created by Akash Bhardwaj on 2023-12-29.
//

import Foundation
class Favourites: ObservableObject {
    private var resorts: Set<String>
    private let saveKey = "Favourites"

    init() {
        self.resorts = []
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
        
    }
}
