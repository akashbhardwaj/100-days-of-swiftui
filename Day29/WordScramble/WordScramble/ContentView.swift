//
//  ContentView.swift
//  WordScramble
//
//  Created by Akash Bhardwaj on 2023-08-22.
//

import SwiftUI

struct ContentView: View {
    let people = ["Finn", "Leia", "Luke"]
    var body: some View {
        listExample
    }

    var listExample: some View {
        List {
            Section("Section 1") {
                Text("Hello Worlds")
                Text("Hello Worlds")
            }
            Section("Section 2") {
                ForEach(people, id: \.self) {
                    Text($0)
                }
            }
            Section("Section 3") {
                Text("Bye Worlds")
                Text("Bye Worlds")
            }
        }
        .listStyle(.grouped)
    }

    var loadingResources: some View {
        Text("sd")
    }

    func loadFile() {
        if let fileURL = Bundle.main.url(forResource: "some-file", withExtension: "txt") {
            if let fileContent = try? String(contentsOf: fileURL) {
                print(fileContent)
            }
        }
    }


    func strings () {
        let input = """
a
b
c
"""
        let letters = input.components(separatedBy: .newlines)

    }

    func spelling() {
        let word = "swift"
        let checker = UITextChecker()

        let range = NSRange(location: 0, length: word.utf16.count)

        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")


        let allGood = misspelledRange.location == NSNotFound


    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
