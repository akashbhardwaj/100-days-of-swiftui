//
//  ContentView.swift
//  Challenge
//
//  Created by Akash Bhardwaj on 2023-10-30.
//

import SwiftUI

struct ContentView: View {

    @StateObject var userHelper = UserHelper()

    var body: some View {
        NavigationView {
            List(userHelper.users, id: \.id) { user in
                UserListItemView(user: user, userHelper: userHelper )
            }
        }
        .navigationTitle("Social")
        .task {
            await userHelper.fetchUsers()
        }
    }
}

#Preview {
    ContentView()
}

struct UserListItemView: View {
    let user: User
    let userHelper: UserHelper

    var body: some View {
        NavigationLink {
            UserDetails(user: user, userHelper: userHelper)
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
                    Text(user.name)
                        .font(.title3)

                    Text(user.email)
                        .font(.caption)
                }
            }
        }
    }
}
