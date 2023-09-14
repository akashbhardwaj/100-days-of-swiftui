//
//  ContentView.swift
//  Moonshot
//
//  Created by Akash Bhardwaj on 2023-09-14.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
//        ResizingImage()
//        ScrollViewExample()
//        NavigationLinkExample()
//        HierarchicalCodableData()
        ScrollingGrid()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct ResizingImage: View {
    var body: some View {
        GeometryReader { geo in
            Image("example")
                .resizable()
                .scaledToFit()
//                .scaledToFill()
                .frame(width: geo.size.width * 0.8, height: 300)
                .frame(width: geo.size.width, height: geo.size.height)
        }
    }
}

struct CustomText: View {
    let text: String

    var body: some View {
        Text(text)
    }

    init(text: String) {
        self.text = text
        print("Creating a custom text \(text)")
    }
}

struct ScrollViewExample: View {
    var body: some View {
        ScrollView(.horizontal) {
            // Lazy stacks take full available size
            LazyHStack(spacing: 10) {
                ForEach(0..<100) {
                    CustomText(text: "Item \($0)")
                        .font(.title)
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
}


struct NavigationLinkExample: View {
    var body: some View {
        NavigationView {
            List(0..<100) { row in
                NavigationLink {
                    Text("Detail View \(row)")
                } label: {
                    Text("Row \(row)")
                }
            }
            .navigationTitle("SwiftUI")
        }
    }
}


struct User: Codable {
    let name: String
    let address: Address
}
struct Address: Codable {
    let street: String
    let city: String
}

struct HierarchicalCodableData: View {
    var body: some View {
        Button("Decode  JSON") {
            let input = """
            {
                "name": "Bilbo",
                "address": {
                "street": "555, BB",
                "city": "Nashville"
                }
            }
        """
            let data = Data(input.utf8)

            if let user = try? JSONDecoder().decode(User.self, from: data) {
                print(user.address.street)
            }
        }
    }
}


struct ScrollingGrid: View {
    let layout = [
        GridItem(.adaptive(minimum: 80, maximum: 120)),
    ]

    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: layout) {
                ForEach(0..<1000) {
                    Text("Item \($0)")
                }
            }
        }
    }
}
