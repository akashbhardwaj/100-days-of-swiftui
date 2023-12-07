//
//  ContentView.swift
//  HotProspects
//
//  Created by Akash Bhardwaj on 2023-12-07.
//

import SwiftUI

@MainActor class User: ObservableObject {
    @Published var name = "Taylor Swift"
}

struct EditView: View {
    @EnvironmentObject var user: User
    var body: some View {
        TextField("Name", text: $user.name)
    }
}

struct DisplayView: View {
    @EnvironmentObject var user: User
    var body: some View {
        Text(user.name)
    }
}

struct ContentView: View {
    @StateObject var user = User()

    var body: some View {
        VStack {
            EditView()
            DisplayView()
        }
        .environmentObject(user)
        .padding()
    }
}

#Preview {
    ContentView()
}
