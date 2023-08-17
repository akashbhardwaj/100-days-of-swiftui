//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Akash Bhardwaj on 2023-08-15.
//

import SwiftUI

struct ContentView: View {
    enum GameMove: String {
        case rock = "Rock", paper = "Paper", scissors = "Scissors"
        var beatingMove: GameMove {
            switch self {
            case .paper:
                return .scissors
            case .rock:
                return .paper
            case .scissors:
                return .rock
            }
        }

        var image: Image {
            switch self {
            case .rock:
                return Image(systemName: "mountain.2")
            case .paper:
                return .init(systemName: "newspaper")
            case .scissors:
                return .init(systemName: "scissors")
            }
        }
    }
    let moves: [GameMove] = [.rock, .paper, .scissors]
    @State private var appsMove: GameMove = .paper
    @State private var shouldWin: Bool = false
    @State private var score: Int = 0

    var body: some View {
        VStack {
            Spacer()
            Text("Computer chooses \"\(appsMove.rawValue)\"")
                .font(.largeTitle)
                .padding()
            Text("The player should \(shouldWin ? "Win" : "Loose")")
                .font(.title)
                .foregroundColor(shouldWin ? .green : .red)
            Spacer()
            Text("Score \(score)")
                .foregroundColor(.black)
                .font(.title2)
                .padding()
                .background(.yellow)
                .clipShape(Capsule(style: .circular))
            Spacer()
            HStack {
                ForEach(moves, id: \.rawValue) { move in
                    Button {
                        userChose(move)
                    } label: {
                        VStack {
                            move.image
                                .foregroundColor(.white)
                            Text("\(move.rawValue)")
                                .font(.title2)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                        }
                        .padding()
                        .background(.cyan)
                        .cornerRadius(10)
                    }
                }
            }
            Spacer()
        }
        .padding(.horizontal, 10.0)
        .onAppear {
            nextMove()
        }
    }

    private func userChose(_ move: GameMove) {
        if (appsMove.beatingMove == move) == shouldWin {
            score += 1
        } else {
            if score > 0 {
                score -= 1
            }
        }
        nextMove()
    }
    private func nextMove() {
        appsMove = moves.randomElement() ?? .rock
        shouldWin.toggle()
    }


}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
