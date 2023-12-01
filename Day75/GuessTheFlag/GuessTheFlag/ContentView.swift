//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Akash Bhardwaj on 2023-08-08.
//

import SwiftUI

struct ContentView: View {

    @State
    private var countries: [String] = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()

    let labels = ["Estonia": "Some flag description",
                  "France": "Some flag description",
                  "Germany": "Some flag description",
                  "Ireland": "Some flag description",
                  "Italy": "Some flag description",
                  "Monaco": "Some flag description",
                  "Nigeria": "Some flag description",
                  "Poland": "Some flag description",
                  "Russia": "Some flag description",
                  "Spain": "Some flag description",
                  "UK": "Some flag description",
                  "US": "Some flag description"]

    @State
    private var correctAnswer = Int.random(in: 0...2)

    @State private var showingScore = false
    @State private var title = ""

    @State var tappedIndex: Int?
    @State var shouldFade = false

    @State private var score = 0
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()

            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))

                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }

                    ForEach(0..<3) { number in
                        Button {
                            didSelectFlag(at: number)
                        } label: {
                            let country = countries[number]
                            FlagImage(country: country)
                                .accessibilityLabel(labels[country, default: "Unknown flag"])
                        }
                        .rotation3DEffect(.degrees(tappedIndex == number ? 360.0 : 0.0), axis: (x: 0, y: 1, z: 0))
                        .opacity(shouldFade && tappedIndex != number ? 0.25 : 1.0)
                        .scaleEffect(tappedIndex == number ? 1.2 : 1.0)
                        .zIndex(tappedIndex == number ? 1 : 0)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.thickMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))

                Spacer()
                Spacer()

                Text("Score \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Spacer()
            }
            .padding()
        }
        .alert(title, isPresented: $showingScore) {
            Button("Continue") {
                askQuestion()
            }
        } message: {
            Text("Your score is \(score)")
        }
    }

    private func didSelectFlag(at index: Int) {
        withAnimation {
            tappedIndex = index
            shouldFade = true
        }
        checkAnswer(index)
        flagTapped(index)
    }

    private func checkAnswer(_ number: Int) {
        if number == correctAnswer {
            score += 1
        }
    }

    private func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        tappedIndex = nil
        shouldFade = false
    }

    private func flagTapped(_ number: Int) {
        if number == correctAnswer {
            title = "Correct"
        } else {
            title = "Wrong"
        }
        showingScore = true
    }
}
struct FlagImage: View {
    let country: String
    var body: some View {
        Image(country)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

