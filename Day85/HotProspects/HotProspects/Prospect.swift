//
//  Prospect.swift
//  HotProspects
//
//  Created by Akash Bhardwaj on 2023-12-13.
//

import SwiftUI

class Prospect: Identifiable, Codable {
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    fileprivate(set) var isContacted = false
    private(set) var dateCreated = Date()
}


@MainActor class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]
    private let savedPath = FileManager.documentDirectory.appendingPathComponent("SavedData")

    init() {
        if let data = try? Data(contentsOf: savedPath) {
            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
                people = decoded
                return
            }
        }
        self.people = []
    }

    private func save() {
        if let encoded = try? JSONEncoder().encode(people) {
            try? encoded.write(to: savedPath, options: [.atomic])
        }
    }

    func toggle(prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }

    func add(_ prospect: Prospect) {
        objectWillChange.send()
        people.append(prospect)
        save()
    }
}
