//
//  GroupExample.swift
//  SnowSeeker
//
//  Created by Akash Bhardwaj on 2023-12-27.
//

import SwiftUI

struct UserView: View {
    var body: some View {
        Group {
            Text("Name: Akash")
            Text("Country: Canada")
            Text("Pets: NA")
        }
        .font(.title)
    }
}

struct GroupExample: View {

    @Environment(\.horizontalSizeClass) var sizeClass
    var body: some View {
        Group {
            if sizeClass == .compact {
                VStack(content: UserView.init)
            } else {
                HStack(content: UserView.init)
            }
        }
    }
}

#Preview {
    GroupExample()
}
