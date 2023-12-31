//
//  ContentView.swift
//  FlashZilla
//
//  Created by Akash Bhardwaj on 2023-12-17.
//

import SwiftUI
extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(x: 0, y: offset * 10)
    }
}
struct ContentView: View {
    @State private var cards = Array<Card>(repeating: .example, count: 10)

    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .ignoresSafeArea()

            VStack {
                ZStack {
                    ForEach(0..<cards.count, id: \.self) { index in
                        CardView(card: cards[index]) {
                            removeCard(at: index)
                        }
                        .stacked(at: index, in: cards.count)
                    }
                }
            }
        }
    }

    func removeCard(at index: Int) {
        cards.remove(at: index)
    }

}

#Preview {
    ContentView()
}
