//
//  ContentView.swift
//  FlashZilla
//
//  Created by Akash Bhardwaj on 2023-12-17.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GesturesView()
    }
}

#Preview {
    ContentView()
}

struct GesturesView: View {
    var body: some View {
        NavigationView(content: {
            List {
                NavigationLink("LongPress", destination: LonPressView())
                NavigationLink("Magnification", destination: MagnificationGestureView())
                NavigationLink("Rotation", destination: RotationGestureView())
                NavigationLink("Mutliple", destination: MultipleGesturesView())
            }
        })
    }
}
struct LonPressView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .onLongPressGesture(minimumDuration: 2) {
            print("Long Pressed")
        } onPressingChanged: { inProgress in
            print("In Progress \(inProgress)")
        }
    }
}

struct MagnificationGestureView: View {
    @State private var currentAmount = 0.0
    @State private var finalAmount = 1.0

    var body: some View {
        Text("Hello, world!")
            .padding()
            .background(.red)
            .scaleEffect(finalAmount + currentAmount)
            .gesture(
                MagnificationGesture()
                    .onChanged { amount in
                        currentAmount = amount - 1
                    }
                    .onEnded { amount in
                        finalAmount += currentAmount
                        currentAmount = 0
                    }
            )
    }
}

struct RotationGestureView: View {
    @State private var currentAmount = Angle.zero
    @State private var finalAmount = Angle.zero

    var body: some View {
        Text("Hello, world!")
            .padding()
            .background(.red)
            .rotationEffect(finalAmount + currentAmount)
            .gesture(
                RotationGesture()
                    .onChanged { angle in
                        currentAmount = angle
                    }
                    .onEnded { angle in
                        finalAmount += currentAmount
                        currentAmount = .zero
                    }
            )
    }
}

struct MultipleGesturesView: View {
    //        .onTapGesture {
    //            print("Parent")
    //        }
            // High Priority gesture to override child gesture
//            .highPriorityGesture(
//                TapGesture()
//                    .onEnded {
//                        print("Parent")
//                    }
//            )
            // Both child parent same time
            //.simultaneousGesture()

    @State private var offset = CGSize.zero
    @State private var isDragging = false

    var body: some View {
        let dragGesture = DragGesture()
            .onChanged { value in
                offset = value.translation
            }
            .onEnded { _ in
                offset = .zero
                isDragging = true
            }

        let pressGesture = LongPressGesture()
            .onEnded { value     in
                withAnimation {
                    isDragging = true
                }
            }

        let combined = pressGesture.sequenced(before: dragGesture)

        Circle()
            .fill(.red)
            .frame(width: 64, height: 64)
            .scaleEffect(isDragging ? 1.5 : 1.0)
            .offset(offset)
            .gesture(combined)

    }
}
