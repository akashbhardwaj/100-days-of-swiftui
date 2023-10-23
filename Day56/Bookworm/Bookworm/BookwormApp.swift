//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Akash Bhardwaj on 2023-10-17.
//

import SwiftUI

@main
struct BookwormApp: App {
    @StateObject private var dataController = DataController()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
