//
//  ContentView.swift
//  Animations
//
//  Created by Akash Bhardwaj on 2023-08-29.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        NavigationView {
            List {
                NavigationLink("Controlling Animations", destination: { ControllingAnimation() })
                NavigationLink("AnimatingGestures", destination: { AnimatingGestures() })
                NavigationLink("AnimatingGestures2", destination: { AnimatingGestures2() })
                NavigationLink("ShowHideViews", destination: { ShowHideViews() })
                NavigationLink("AnimationViewModifier", destination: { AnimationViewModifier() })
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct ControllingAnimation: View {
    @State private var enabled = false

    var body: some View {
        Button("Tap me") {
            enabled.toggle()
        }
        .frame(width: 200, height: 200)
        .background(enabled ? .blue : .red)
        .animation(.default, value: enabled)
        .foregroundColor(.white)
        .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
        .animation(.interpolatingSpring(stiffness: 10, damping: 1), value: enabled)
    }
}


struct AnimatingGestures: View {
    @State private var dragAmount = CGSize.zero

    var body: some View {
        LinearGradient(gradient: .init(colors: [.yellow, .red]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .frame(width: 300, height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .offset(dragAmount)
            .gesture(
                DragGesture()
                    .onChanged({ dragAmount = $0.translation })
                    .onEnded({ _ in
                        withAnimation {
                            dragAmount = .zero
                        }
                    })
            )
//            .animation(.spring(), value: dragAmount)
    }
}
struct AnimatingGestures2: View {
    let letters = Array("Hello SwiftUI")
    @State private var enabled = true
    @State private var dragAmount = CGSize.zero
    var body: some View {
        HStack(spacing: 0   ) {
            ForEach(0..<letters.count) { num in
                Text(String(letters[num]))
                    .padding(5)
                    .font(.title)
                    .background(enabled ? .blue : .red)
                    .offset(dragAmount)
                    .animation(.default.delay(Double(num) / 20), value: dragAmount)
            }
        }
        .gesture(
            DragGesture()
                .onChanged({ dragAmount = $0.translation })
                .onEnded { _ in
                    dragAmount = .zero
                    enabled.toggle()
                }
        )
    }
}

struct ShowHideViews: View {
@State private var isShowingRed = false
    var body: some View {
        VStack {
            Button("Tap Me") {
                withAnimation {
                    isShowingRed.toggle()
                }
            }
            if isShowingRed {
                Rectangle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
                    .transition(.asymmetric(insertion: .scale, removal: .scale))
            }
        }
    }
}



struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(active: CornerRotateModifier(amount: -90, anchor: .topLeading), identity: CornerRotateModifier(amount: 0, anchor: .topLeading))
    }
}

struct AnimationViewModifier: View {

    @State private var isShowingRed = false
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.blue)
                .frame(width: 200, height: 200)

            if isShowingRed {
                Rectangle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
                    .transition(.pivot)
            }
        }
        .onTapGesture {
            withAnimation {
                isShowingRed.toggle()
            }
        }
    }
}


