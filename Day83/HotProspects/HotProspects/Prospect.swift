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
}


@MainActor class Prospects: ObservableObject {
    @Published var people: [Prospect]

    init() {
        self.people = []
    }

    func toggle(prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
    }
}
