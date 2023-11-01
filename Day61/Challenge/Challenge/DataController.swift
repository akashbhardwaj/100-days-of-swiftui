//
//  DataController.swift
//  Challenge
//
//  Created by Akash Bhardwaj on 2023-10-31.
//

import CoreData
class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Challenge")

    init() {
        container.loadPersistentStores { description, error in
            if let error {
                print("Loading stores failed \(error.localizedDescription)")
                return
            }

            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
    }
}
