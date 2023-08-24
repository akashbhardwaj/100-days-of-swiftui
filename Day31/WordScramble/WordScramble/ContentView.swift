//
//  ContentView.swift
//  WordScramble
//
//  Created by Akash Bhardwaj on 2023-08-22.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""

    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingAlert = false

    var score: Int {
        return usedWords.reduce(0, { $0 + $1.count })
    }

    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Enter your word", text:  $newWord)
                        .autocapitalization(.none)
                }
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName:  "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            .navigationTitle(rootWord)
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
            .toolbar {
                ToolbarItemGroup {
                    Button("Restart") {
                        startGame()
                    }
                }
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Text("Score \(score)")
                        .foregroundColor(.blue)
                        .font(.title)
                }
            }
            .alert(errorTitle, isPresented: $showingAlert) {
                Button("Ok", role: .cancel) {}
            } message: {
                Text(errorMessage)
            }
        }
    }

    func addNewWord() {
        let answer = newWord
            .lowercased()
            .trimmingCharacters(in: .whitespaces)

        guard answer.count > 2 else {
            wordError(title: "Too short!!", message: "Please use a word with more than 3 characters")
            return
        }


        guard isDifferent(word: answer) else {
            wordError(title: "Try something else!", message: "Don't use the root word")
            return
        }

        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }

        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You can't spell word from '\(rootWord)'")
            return
        }

        guard isReal(word: answer) else {
            wordError(title: "Word not recogonized", message: "You can't just make them up!!")
            return
        }

        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        newWord = ""
    }

    func startGame() {
        if let startWordsUrl = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsUrl) {
                let allWords = startWords.components(separatedBy: .newlines)
                rootWord = allWords.randomElement() ?? "silkworm"
                usedWords.removeAll()
                return
            }
        }
        fatalError("could not load start.txt")
    }


    func isDifferent(word: String) -> Bool {
        return word.lowercased() != rootWord.lowercased()
    }

    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }

    func isPossible(word: String) -> Bool {
        var tempWord = rootWord

        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }

        return true
    }

    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)

        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

        return misspelledRange.location == NSNotFound
    }

    func wordError(title: String, message: String) {
        errorMessage = message
        errorTitle = title
        showingAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
