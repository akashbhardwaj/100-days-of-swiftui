//
//  ValuesOfControlExample.swift
//  AccessibilityProject
//
//  Created by Akash Bhardwaj on 2023-11-30.
//

import SwiftUI

struct ValuesOfControlExample: View {

    @State private var value = 10

    var body: some View {
        VStack {
            Text("Value: \(value)")

            Button("Increment") {
                value += 1
            }

            Button("Decrement") {
                value -= 1
            }
        }
        .accessibilityElement()
        .accessibilityLabel("Value")
        .accessibilityValue(String(value))
        .accessibilityAdjustableAction { direction in
            switch direction {
            case .increment:
                value += 1
            case .decrement:
                value -= 1
            default:
                print("Not Handled")
            }
        }
    }
}

#Preview {
    ValuesOfControlExample()
}
