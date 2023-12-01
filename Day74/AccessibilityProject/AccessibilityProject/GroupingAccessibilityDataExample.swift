//
//  GroupingAccessibilityDataExample.swift
//  AccessibilityProject
//
//  Created by Akash Bhardwaj on 2023-11-30.
//

import SwiftUI

struct GroupingAccessibilityDataExample: View {
    var body: some View {
        VStack {
            Text("Your score is")
            Text("1000")
                .font(.title)
        }
//        .accessibilityElement(children: .combine)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Your score is 1000, yay!")
    }
}

#Preview {
    GroupingAccessibilityDataExample()
}
