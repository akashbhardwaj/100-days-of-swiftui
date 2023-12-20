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
    @State private var cards = [Card]()
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor

    @State private var timeRemaining = 100
    @Environment(\.scenePhase) var scenePhase
    @State private var isActive = true
    @Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnabled
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var showingEditScreen = false


    var body: some View {
        ZStack {
            Image(decorative: "background")
                .resizable()
                .ignoresSafeArea()

            VStack {
                Text("Time: \(timeRemaining)")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(.black.opacity(0.5))
                    .clipShape(Capsule())

                ZStack {
                    ForEach(Array(cards.enumerated()), id: \.element.id) { index, card in
                        CardView(card: card) { isWrong in
                            remove(card: card, isWrong: isWrong)
                        }
                        .stacked(at: index, in: cards.count)
                        .allowsHitTesting(index == cards.count - 1)
                        .accessibilityHidden(index < cards.count - 1)
                    }
                }
                .allowsHitTesting(timeRemaining > 0)

                if cards.isEmpty {
                    Button("Start Again") {
                        resetCards()
                    }
                    .padding()
                    .background(.black)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                }
            }

            VStack {
                HStack {
                    Spacer()

                    Button {
                        showingEditScreen = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(.black.opacity(0.7))
                            .clipShape(Circle())
                    }
                }

                Spacer()
            }
            .foregroundStyle(.white)
            .font(.largeTitle)
            .padding()

            if differentiateWithoutColor || voiceOverEnabled {
                VStack {
                    Spacer()

                    HStack {
                        Button {
                            withAnimation {
                                remove(card: cards.last ?? .example, isWrong: true)
                            }
                        } label: {
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibilityLabel("Wrong")
                        .accessibilityHint("Mark your answer as incorrect")
                        Spacer()
                        Button {
                            withAnimation {
                                remove(card: cards.last ?? .example, isWrong: false)
                            }
                        } label: {
                            Image(systemName: "checkmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibilityLabel("Correct")
                        .accessibilityHint("Mark your answer as correct")
                    }
                    .foregroundStyle(.white)
                    .font(.largeTitle)
                    .padding()
                }
            }
        }
        .onReceive(timer) { time in
            guard isActive else { return }
            if timeRemaining > 0 {
                timeRemaining -= 1
            }
        }
        .onChange(of: scenePhase) { _, newValue in
            if newValue == .active {
                if !cards.isEmpty {
                    isActive = true
                }
            } else {
                isActive = false
            }
        }
        .sheet(isPresented: $showingEditScreen, onDismiss: resetCards, content: EditCards.init)
        .onAppear(perform: resetCards)
    }

    func loadData() {
        cards = CardsHelper.getCards()
    }

    func remove(card: Card, isWrong: Bool) {
        guard let index = cards.firstIndex(where: {card.id == $0.id}) else { return }
        cards.remove(at: index)
        if isWrong {
            var newCard = card
            newCard.id = UUID()
            cards.insert(newCard, at: 0)
        }
        if cards.isEmpty {
            isActive = false
        }
    }

    func resetCards() {
        loadData()
        timeRemaining = 100
        isActive = true
    }

}

#Preview {
    ContentView()
}
