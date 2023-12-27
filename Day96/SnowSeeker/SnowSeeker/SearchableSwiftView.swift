//
//  SearchableSwiftView.swift
//  SnowSeeker
//
//  Created by Akash Bhardwaj on 2023-12-27.
//

import SwiftUI

struct SearchableSwiftView: View {
    @State private var searchText = ""
    let allNames = ["Subh", "Vina", "malvin", "Stefinie"]
    var body: some View {
        NavigationView {
            List(filteredNames, id: \.self) { name in
                Text(name)
            }
            .searchable(text: $searchText, prompt: "Look for something")
            .navigationTitle("Searching")
        }
    }

    var filteredNames: [String] {
        if searchText.isEmpty {
            return allNames
        } else {
            return allNames.filter({ $0.localizedCaseInsensitiveContains(searchText)})
        }
    }
}

#Preview {
    SearchableSwiftView()
}
