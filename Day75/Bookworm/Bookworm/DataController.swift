//
//  DataController.swift
//  Bookworm
//
//  Created by Akash Bhardwaj on 2023-10-17.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Bookworm")

    init() {
        container.loadPersistentStores { description, error in
            if let error {
                print("Core data failed to load \(error.localizedDescription)")
            }
        }
    }
}
