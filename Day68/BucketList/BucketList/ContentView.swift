//
//  ContentView.swift
//  BucketList
//
//  Created by Akash Bhardwaj on 2023-11-17.
//

import SwiftUI
struct User: Identifiable {
    let id = UUID()
    let firstName: String
    let lastName: String
}
extension User: Comparable {
    static func < (lhs: User, rhs: User) -> Bool {
        lhs.lastName < rhs.lastName
    }
}

struct ContentView: View {
    let users = [
        User(firstName: "Arnold", lastName: "Rimmer"),
        User(firstName: "Kristin", lastName: "Kochanski"),
        User(firstName: "David", lastName: "Adade"),
    ].sorted()

    var body: some View {
        List(users) { user in
            Text("\(user.firstName) \(user.lastName)")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
