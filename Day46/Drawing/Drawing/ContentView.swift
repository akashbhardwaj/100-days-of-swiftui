//
//  ContentView.swift
//  Drawing
//
//  Created by Akash Bhardwaj on 2023-09-20.
//

import SwiftUI

struct ContentView: View {
    @State private var insetAmount = 0.0
    var body: some View {
//        MetalExample()
        Arrow(insetAmount: insetAmount)
            .fill(.blue)
            .onTapGesture {
                withAnimation {
                    insetAmount = Double.random(in: -10...30)
                }
            }
    }
}

struct Arrow: Shape {
    var insetAmount: CGFloat = 0.0

    var animatableData: Double {
        get { insetAmount }
        set { insetAmount = newValue}
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: .init(x: rect.midX, y: rect.minY))
        path.addLine(to: .init(x: rect.maxX + insetAmount, y: rect.maxY))
        path.addLine(to: .init(x: rect.midX, y: rect.midY))
        path.addLine(to: .init(x: rect.minX - insetAmount, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
struct ColorCyclingRectangleView: View {
    var  amount = 0.0
    var steps = 100
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Rectangle()
                    .inset(by: Double(value))
                    .strokeBorder(
                        color(for: value, brightness: 1),
                        lineWidth: 2)

            }
        }
        .drawingGroup()
    }

    func color(for value: Int, brightness: Double) ->  Color {
        var targetHue = Double(value) / Double(steps) + amount
        if targetHue > 1 {
            targetHue -= 1
        }
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}


struct MetalExample: View {
    @State private var colorCycle = 0.0
    var body: some View {
        VStack {
            ColorCyclingRectangleView(amount: colorCycle)
                .frame(width: 300, height: 250)
            Slider(value: $colorCycle)
        }
    }
}


