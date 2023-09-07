//
//  ContentView.swift
//  edutainment
//
//  Created by Akash Bhardwaj on 2023-09-06.
//

import SwiftUI

struct ContentView: View {
    @State private var showingSheet = false

    @State private var questions: [Question] = []
    @State private var questionNumber: Int = 0

    @State private var numberOfQuestions: Int = 5
    @State private var answer: String = ""
    @State private var difficultyLevel = 10
    @State private var score = 0

    @State private var showingAlert = false

    var body: some View {
        NavigationView {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(LinearGradient(colors: [.yellow,.blue], startPoint: .top, endPoint: .bottom))
                    .ignoresSafeArea()
                if !questions.isEmpty {
                    VStack {
                        Spacer()
                        Text("Question number \(questionNumber + 1)")
                        Text(questions[questionNumber].question)
                            .font(.largeTitle)
                        UnderlineTextField(text: $answer)
                        Button("Submit") {
                            checkAnswer()
                        }
                        .foregroundColor(.white)
                        .padding()
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                        Spacer()
                        Spacer()
                    }
                    .padding()
                }
            }
            .sheet(isPresented: $showingSheet, content: { SettingsView(difficultyLevel: difficultyLevel, numberOfQuestions: Double(numberOfQuestions), save: { newLevel, newNumber in
                difficultyLevel = newLevel
                numberOfQuestions = newNumber
                generateQuestions()
            })})
            .alert("Your score is..", isPresented: $showingAlert, actions: {
                Button("Play Again") {
                    resetGame()
                }
            }, message: {
                Text("Your gave \(score) correct answers! \n Do you want to play again?")
            })
            .toolbar {
                ToolbarItemGroup {
                    Button {
                        showingSheet.toggle()
                    } label: {
                        Image(systemName: "gear.circle")
                    }

                }
            }
            .navigationTitle("Edutainment")
        }
        .onAppear {
            generateQuestions()
        }
    }

    func resetGame() {
        score = 0
        questionNumber = 0
        generateQuestions()
    }
    func checkAnswer() {
        if questions[questionNumber].answer == Int(answer) ?? 0 {
            score += 1
        } else {

        }
        if questionNumber < questions.count - 1 {
            questionNumber += 1
        } else {
            showingAlert = true
        }
        answer = ""
    }

    func generateQuestions() {
        var generatedQuestions = [Question]()
        (0..<numberOfQuestions).forEach { _ in
            let randomNumber = (2...difficultyLevel).randomElement() ?? 2
            let randomMultiplier = (2...difficultyLevel).randomElement() ?? 2
            generatedQuestions.append(Question(question: "What is \(randomNumber) times \(randomMultiplier)", answer: randomNumber * randomMultiplier))
        }
        questions = generatedQuestions
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct UnderlineTextField: View {
    @Binding var text: String

    var body: some View {
        HStack {
            Spacer(minLength: 40)
            VStack(spacing: 0) {
                TextField("Answer", text: $text)
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(.plain)
                    .background(.clear)
                    .keyboardType(.numberPad)
                Rectangle()
                    .fill(.black)
                    .frame(height: 1)
            }
            Spacer(minLength: 40)
        }
    }
}
struct SettingsView: View {
    @State var difficultyLevel = 2
    @State var numberOfQuestions = 5.0
    @Environment(\.dismiss) var dismissAction

    let save: ((_ difficultyLevel: Int, _ numberOfQuestions: Int) -> Void)


    var body: some View {
        ZStack {
            RadialGradient(stops: [.init(color: .red, location: 0.3), .init(color: .blue, location: 0.3)], center: .bottom, startRadius: 650, endRadius: 700)
                .blur(radius: 2)
                .ignoresSafeArea()
            VStack {
                VStack {
                    Text("Difficulty level (2 to 20)")
                        .font(.headline)
                    Stepper("Difficulty level \(difficultyLevel)", value: $difficultyLevel, in: 2...20)
                }
                .clipShape(RoundedRectangle(cornerRadius: 4))
                .padding()

                VStack {
                    Text("Number of questions \(Int(numberOfQuestions))")
                        .font(.headline)
                    Slider(value: $numberOfQuestions, in: 5...20, step: 5.0) {
                        Text("Number of questions \(numberOfQuestions)")
                    }
                    .tint(.black)
                }
                .padding()

                Button {
                    save(difficultyLevel, Int(numberOfQuestions) )
                    dismissAction()
                } label: {
                    Image(systemName: "arrow.down.app")
                        .resizable()
                        .frame(width: 80, height: 80)
                }

            }
        }
        .navigationTitle("Settings")

    }
}

struct Question {
    var question: String
    var answer: Int
}
