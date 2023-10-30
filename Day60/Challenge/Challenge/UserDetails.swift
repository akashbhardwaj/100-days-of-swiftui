//
//  UserDetails.swift
//  Challenge
//
//  Created by Akash Bhardwaj on 2023-10-30.
//

import SwiftUI

struct UserDetails: View {
    let user: User
    let userHelper: UserHelper

    var body: some View {
        List {
            Section {
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 100, height: 100)

                        VStack(alignment: .leading) {
                            Text(user.name)
                                .font(.largeTitle)
                            Text("\(user.age)")

                            Text(user.email)
                            Text(user.company)
                            Text(user.address)
                            Text("Registered On:")
                            Text(user.registered.formatted(date: .abbreviated, time: .omitted))
                        }
                        .padding([.bottom], 10)
                    }
                    TagsView(tags: user.tags)
                    Text(user.about)
                }
                .padding([.horizontal])
            }

            ForEach(user.friends, id: \.id) { friend in
                NavigationLink {
                    if let user = userHelper.fetchUser(with: friend.id) {
                        UserDetails(user: user, userHelper: userHelper)

                    }

                } label: {
                    Text(friend.name)
                        .foregroundStyle(.black)
                }
            }
        }
        .navigationTitle(user.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}


struct TagsView: View {
    let tags: [String]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(tags, id: \.self) {
                    Text($0)
                        .foregroundStyle(.white)
                        .padding([.horizontal])
                        .background(
                            Capsule()
                                .foregroundStyle(.blue)
                        )
                }
            }
        }
    }
}

