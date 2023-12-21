//
//  GeometryReaderExample.swift
//  LayoutAndGeometry
//
//  Created by Akash Bhardwaj on 2023-12-21.
//

import SwiftUI

struct OuterView: View {
    var body: some View {
        VStack {
            Text("Top")
            InnerView()
                .background(.green)
            Text("Bottom")
        }
    }
}
struct InnerView: View {
    var body: some View {
        HStack {
            Text("left")
            GeometryReader { geo in
                Text("Center")
                    .background(.blue)
                    .onTapGesture {
                        print("global center: \(geo.frame(in: .global).midX) X \(geo.frame(in: .global).midY)")
                        print("local center: \(geo.frame(in: .local).midX) X \(geo.frame(in: .local).midY)")
                        print("local center: \(geo.frame(in: .named("Custom")).midX) X \(geo.frame(in: .named("Custom")).midY)")
                    }
            }
            .background(.orange)
            Text("Right")
        }
    }
}
struct GeometryReaderExample: View {
    var body: some View {
        OuterView()
            .background(.red)
            .coordinateSpace(.named("Custom"))
    }
}

#Preview {
    GeometryReaderExample()
}
