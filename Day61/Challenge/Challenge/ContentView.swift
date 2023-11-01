//
//  ContentView.swift
//  Challenge
//
//  Created by Akash Bhardwaj on 2023-10-30.
//

import CoreData
import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var context
    @FetchRequest(sortDescriptors: []) var users: FetchedResults<CachedUser>

    var body: some View {
        NavigationView {
            List(users, id: \.id) { user in
                UserListItemView(user: user)
            }
        }
        .navigationTitle("Social")
        .onAppear {
            Task {
                await fetchUsers()
            }
        }
    }

    func fetchUsers() async {
        guard users.isEmpty else {
            return
        }

        let users = await UserHelper().fetchUsers()
        users.forEach { user in
            let newCachedUser = CachedUser(context: context)
            newCachedUser.id = user.id
            newCachedUser.isActive = user.isActive
            newCachedUser.name = user.name
            newCachedUser.age = Int16(user.age)
            newCachedUser.company = user.company
            newCachedUser.email = user.email
            newCachedUser.address = user.address
            newCachedUser.about = user.about
            newCachedUser.registered = user.registered
            newCachedUser.tags = user.tags.joined(separator: ",")
            let cachedFriends = user.friends.map { friend in
                let newCachedFriend = CachedFriend(context: context)
                newCachedFriend.id = friend.id
                newCachedFriend.name = friend.name
                return newCachedFriend
            }
            newCachedUser.friends = NSSet(array: cachedFriends)
        }

        try? context.save()
    }
}

#Preview {
    ContentView()
}

struct UserListItemView: View {
    let user: CachedUser

    var body: some View {
        NavigationLink {
            UserDetails(userId: user.wrappedId)
        } label: {
            HStack {
                ZStack(alignment: .topTrailing) {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .frame(width: 44, height: 44)

                    Circle()
                        .frame(width: 10, height: 10)
                        .foregroundStyle(user.isActive ? .green : .gray)
                }

                VStack(alignment: .leading) {
                    Text(user.wrappedName)
                        .font(.title3)

                    Text(user.wrappedEmail)
                        .font(.caption)
                }
            }
        }
    }
}
