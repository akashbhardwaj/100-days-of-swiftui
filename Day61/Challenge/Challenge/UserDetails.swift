//
//  UserDetails.swift
//  Challenge
//
//  Created by Akash Bhardwaj on 2023-10-30.
//

import SwiftUI

struct UserDetails: View {
    @Environment(\.managedObjectContext) var context
    @FetchRequest private var userFetchRequest: FetchedResults<CachedUser>

    var user: CachedUser {
        userFetchRequest.first!
    }

    init(userId: String) {
        _userFetchRequest = FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "id == %@", userId))
    }

    var body: some View {
        List {
            Section {
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 100, height: 100)

                        VStack(alignment: .leading) {
                            Text(user.wrappedName)
                                .font(.largeTitle)
                            Text("\(user.age)")

                            Text(user.wrappedEmail)
                            Text(user.wrappedCompany)
                            Text(user.wrappedAddress)
                            Text("Registered On:")
                            Text(user.wrappedRegistered.formatted(date: .abbreviated, time: .omitted))
                        }
                        .padding([.bottom], 10)
                    }
                    TagsView(tags: user.wrappedTags)
                    Text(user.wrappedAbout)
                }
                .padding([.horizontal])
            }

            ForEach(user.wrappedFriends, id: \.id) { friend in
                NavigationLink {
                    UserDetails(userId: friend.wrappedId)
                } label: {
                    Text(friend.wrappedName)
                        .foregroundStyle(.black)
                }
            }
        }
        .navigationTitle(user.wrappedName)
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

