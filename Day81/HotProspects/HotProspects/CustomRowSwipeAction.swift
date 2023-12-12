//
//  CustomRowSwipeAction.swift
//  HotProspects
//
//  Created by Akash Bhardwaj on 2023-12-12.
//

import SwiftUI

struct CustomRowSwipeAction: View {
    var body: some View {
        List {
            Text("Taylor Swift")
                .swipeActions {
                    Button(role: .destructive) {
                        print("deleting")
                    } label: {
                        Label("Delete", systemImage: "minus.circle")
                    }
                }
                .swipeActions(edge: .leading) {
                    Button(role: .destructive) {
                        print("pining")
                    } label: {
                        Label("Pin", systemImage: "pin")
                            .tint(.orange)
                    }
                }
        }
    }
}

#Preview {
    CustomRowSwipeAction()
}
