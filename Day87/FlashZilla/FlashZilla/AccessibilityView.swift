//
//  AccessibilityView.swift
//  FlashZilla
//
//  Created by Akash Bhardwaj on 2023-12-18.
//

import SwiftUI

func withOptionalAnimation<Result>(_ animation: Animation? = .default, _ body: () throws -> Result) rethrows -> Result {
    if UIAccessibility.isReduceMotionEnabled {
        return try body()
    } else {
        return try withAnimation(animation, body)
    }
}

struct AccessibilityView: View {
    var body: some View {
        List {
            DifferentiateWithoutColorView()
            ReduceMotionView()
            ReduceTransparencyView()
        }
    }
}

#Preview {
    AccessibilityView()
}

struct ReduceTransparencyView: View {
    @Environment(\.accessibilityReduceTransparency) var reduceTransparency

    var body: some View {
        Text("hello world")
            .padding()
            .background(reduceTransparency ? .black : .black.opacity(0.5))
            .foregroundStyle(Color.white)
            .clipShape(Capsule())
    }
}

struct ReduceMotionView: View {
    @Environment(\.accessibilityReduceMotion) var reduceMotion

    @State private var scale = 1.0

    var body: some View {
        Text("hello world")
            .scaleEffect(scale)
            .onTapGesture {
                withOptionalAnimation {
                    scale += 1.5
                }
            }
    }
}

struct DifferentiateWithoutColorView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    var body: some View {
        HStack {
            if differentiateWithoutColor {
                Image(systemName: "checkmark.circle")
            }
            Text("Success")
        }
        .padding()
        .background(differentiateWithoutColor ? .black : .green)
        .foregroundColor(.white)
        .clipShape(Capsule())
    }
}
