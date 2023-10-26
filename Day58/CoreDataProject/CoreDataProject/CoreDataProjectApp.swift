//
//  CoreDataProjectApp.swift
//  CoreDataProject
//
//  Created by Akash Bhardwaj on 2023-10-24.
//

import SwiftUI

@main
struct CoreDataProjectApp: App {
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
