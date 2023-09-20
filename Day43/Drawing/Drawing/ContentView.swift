//
//  ContentView.swift
//  Drawing
//
//  Created by Akash Bhardwaj on 2023-09-20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
//        Triangle()
//        Shapes()
        Strokes()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Triangle: View {
    var body: some View {
        Path { path in
            path.move(to: .init(x: 200, y: 100))
            path.addLine(to: .init(x: 100, y: 300))
            path.addLine(to: .init(x: 300, y: 300))
            path.addLine(to: .init(x: 200, y: 100))
            path.closeSubpath()
            
        }
        .stroke(.blue, style: .init(lineWidth: 10, lineCap: .round, lineJoin: .round))
    }
}


struct TriangleShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: .init(x: rect.midX, y: rect.minY))
        path.addLine(to: .init(x: rect.minX, y: rect.maxY))
        path.addLine(to: .init(x: rect.maxX, y: rect.maxY))
        path.addLine(to: .init(x: rect.midX, y: rect.minY))

        return path
    }
}


struct Arc: Shape, InsettableShape {
    let startAngle: Angle
    let endAngle: Angle
    let clockwise: Bool

    var insetAmount = 0.0

    func path(in rect: CGRect) -> Path {
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStartAngle = startAngle - rotationAdjustment
        let modifiedEndAngle = endAngle - rotationAdjustment
        var path = Path()

        path.addArc(center: .init(x: rect.midX, y: rect.midY), radius: rect.width / 2 - insetAmount, startAngle: modifiedStartAngle, endAngle: modifiedEndAngle, clockwise: !clockwise)

        return path
    }

    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
}

struct Shapes: View {
    var body: some View {

        Arc(startAngle: .degrees(0), endAngle: .degrees(230), clockwise: true)
            .stroke(.blue, lineWidth: 10)
            .frame(width: 300, height: 300)
//        TriangleShape()
//            .stroke(.red, style: .init(lineWidth: 10, lineCap: .round, lineJoin: .round))
//            .frame(width: 300, height: 300)
    }
}


struct Strokes: View {
    var body: some View {
        Arc(startAngle: .degrees(-90), endAngle: .degrees(+90), clockwise: true)
            .strokeBorder(.blue, lineWidth: 40)
    }
}
