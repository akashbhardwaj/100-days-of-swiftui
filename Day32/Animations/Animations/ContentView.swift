//
//  ContentView.swift
//  Animations
//
//  Created by Akash Bhardwaj on 2023-08-29.
//

import SwiftUI

struct ContentView: View {


    var body: some View {
//       Animations()
//        BindingAnimations()
        ExplicitAnimations()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
struct ExplicitAnimations: View {
    @State private var animationAmount = 0.0

    var body: some View {
        Button("Tap me") {
            withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
                animationAmount += 360
            }
        }
        .padding(50)
        .background(.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .rotation3DEffect(.degrees(animationAmount), axis: (x: 0.0, y: 1, z: 0.0))
    }
}
struct BindingAnimations: View {
    @State private var animationAmount = 1.0
    var body: some View {

        print(animationAmount)

        return VStack{
            Stepper("Scale amount", value: $animationAmount.animation(
                .easeIn(duration: 1)
                .repeatCount(3, autoreverses: true)
            ), in: 1...20)

            Spacer()

            Button("Tap me") {
                animationAmount += 1
            }
            .padding(50)
            .background(.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .scaleEffect(animationAmount)
        }
    }
}

struct Animations: View {
    @State private var animationAmount = 1.0

    var body: some View {
        Button("Tap me") {
//            animationAmount += 1
        }
        .padding(50)
        .background(.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .overlay {
            Circle()
                .stroke(.red)
                .scaleEffect(animationAmount)
                .opacity(2 - animationAmount)
                .animation(
                    .easeInOut(duration: 1)
                    .repeatForever(autoreverses: false),
                    value: animationAmount)
        }
        .onAppear {
            animationAmount = 2
        }

    }
}
