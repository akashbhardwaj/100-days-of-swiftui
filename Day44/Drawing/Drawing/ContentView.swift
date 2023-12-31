//
//  ContentView.swift
//  Drawing
//
//  Created by Akash Bhardwaj on 2023-09-20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        //        FlowerExample()
        //        CreateBorderExample()
        MetalExample()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct FlowerExample: View {
    @State private var petalOffSet = -20.0
    @State private var petalWidth = 100.0
    var body: some View {
        VStack {
            Flower(petalOffset: petalOffSet, petalWidth: petalWidth)
                .fill(.red, style: .init(eoFill: true))

            Text("OffSet")
            Slider(value: $petalOffSet, in: -40...40)
                .padding([.horizontal, .bottom])

            Text("Petal Wifth")
            Slider(value: $petalWidth, in: 0...100)
                .padding([.horizontal])
        }
    }
}

struct Flower: Shape {
    var petalOffset = -20.0
    var petalWidth = 100.0

    func path(in rect: CGRect) -> Path {
        var path = Path()

        for number in stride(from: 0, to: Double.pi * 2, by: Double.pi / 8) {
            let rotation = CGAffineTransform(rotationAngle: number)

            let position = rotation.concatenating(CGAffineTransform(translationX: rect.width / 2, y: rect.height / 2))

            let originalPetal = Path(ellipseIn: CGRect(x: petalOffset, y: 0, width: petalWidth, height: rect.width / 2))

            let rotatedPatel = originalPetal.applying(position)

            path.addPath(rotatedPatel)
        }

        return path

    }
}



struct CreateBorderExample: View {
    var body: some View {
        //        Text("hello")
        //            .frame(width: 300, height: 300)
        //            .border(ImagePaint(image: Image(systemName: "globe"), sourceRect: CGRect(x: 0, y: 0.25, width: 1, height: 0.5), scale: 0.2), width: 40)

        Capsule()
            .strokeBorder(ImagePaint(image: Image(systemName: "globe"), sourceRect: CGRect(x: 0, y: 0.25, width: 1, height: 0.5), scale: 0.1), lineWidth: 20)
            .frame(width: 300, height: 200)
    }
}


struct ColorCyclingView: View {
    var  amount = 0.0
    var steps = 100
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Circle()
                    .inset(by: Double(value))
                    .strokeBorder(
                        LinearGradient(gradient: .init(colors: [
                            color(for: value, brightness: 1),
                            color(for: value, brightness: 0.5),
                        ]),
                                       startPoint: .top,
                                       endPoint: .bottom),
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
            ColorCyclingView(amount: colorCycle)
                .frame(width: 300, height: 300)
            Slider(value: $colorCycle)
        }
    }
}
