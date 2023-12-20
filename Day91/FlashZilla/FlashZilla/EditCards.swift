//
//  EditCards.swift
//  FlashZilla
//
//  Created by Akash Bhardwaj on 2023-12-19.
//

import SwiftUI

struct EditCards: View {
    @Environment(\.dismiss) var dismiss
    @State private var cards = [Card]()
    @State private var newPrompt = ""
    @State private var newAnswer = ""
    var body: some View {
        NavigationView {
            List {
                Section("Add new cards") {
                    TextField("Prompt", text: $newPrompt)
                    TextField("Answer", text: $newAnswer)
                    Button("Add Card", action: addCard)
                }
                Section {
                    ForEach(0..<cards.count, id: \.self) { index in
                        VStack(alignment: .leading) {
                            Text(cards[index].prompt)
                                .font(.headline)
                            Text(cards[index].answer)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .onDelete(perform: removeCards)
                }
            }
            .navigationTitle("Edit Card")
            .toolbar {
                Button("Done") {
                    done()
                }
            }
            .listStyle(.grouped)
            .onAppear(perform: loadData)
        }
    }

    func done() {
        dismiss()
    }

    func loadData() {
        cards = CardsHelper.getCards()
    }

    func saveData() {
        CardsHelper.save(cards: cards)
    }

    func addCard() {
        let trimmedPrompt = newPrompt.trimmingCharacters(in: .whitespaces)
        let trimmedAnswer = newAnswer.trimmingCharacters(in: .whitespaces)
        guard !trimmedPrompt.isEmpty && !trimmedAnswer.isEmpty else {
            return
        }
        let card = Card(prompt: trimmedPrompt, answer: trimmedAnswer)
        cards.append(card)
        saveData()
        newPrompt = ""
        newAnswer = ""
    }

    func removeCards(at offsets: IndexSet) {
        cards.remove(atOffsets: offsets)
        saveData()
    }
}

#Preview {
    EditCards()
}

extension FileManager {
    static var documentDirectory: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
