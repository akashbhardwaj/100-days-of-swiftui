//
//  ChallengeApp.swift
//  Challenge
//
//  Created by Akash Bhardwaj on 2023-10-30.
//

import SwiftUI

@main
struct ChallengeApp: App {
    @StateObject var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
