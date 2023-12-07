//
//  TabViewExample.swift
//  HotProspects
//
//  Created by Akash Bhardwaj on 2023-12-07.
//

import SwiftUI

struct TabViewExample: View {
    enum Tags {
        case one, two
    }

    @State private var selectedTab = Tags.one

    var body: some View {
        TabView(selection: $selectedTab) {
            Text("Tab 1")
                .onTapGesture {
                    selectedTab = .two
                }
                .tabItem {
                    Label("One", systemImage: "star")
                }
                .tag(Tags.one)

            Text("Tab 2")
                .tabItem {
                    Label("Two", systemImage: "circle")
                }
                .tag(Tags.two)
        }
    }
}

#Preview {
    TabViewExample()
}
