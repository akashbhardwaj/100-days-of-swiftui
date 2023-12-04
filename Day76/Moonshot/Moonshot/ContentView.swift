//
//  ContentView.swift
//  Moonshot
//
//  Created by Akash Bhardwaj on 2023-09-14.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")

    var columns = [GridItem(.adaptive(minimum: 150))]
    @State private var isList = false

    var body: some View {
        NavigationView {
            Group {
                if isList {
                    ListLayout(astronauts: astronauts, missions: missions)
                } else {
                    GridLayout(astronauts: astronauts, missions: missions)
                }

            }
            .navigationTitle("Moonshot")
            .toolbar {
                Button(isList ? "Grid" : "List") {
                    isList.toggle()
                }
            }
            .background(.darkBackground)
            .preferredColorScheme(.dark)
        }
    }
}

struct GridLayout: View {
    let astronauts: [String: Astronaut]
    let missions: [Mission]
    var columns = [GridItem(.adaptive(minimum: 150))]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(missions, id: \.id) { mission in
                    NavigationLink {
                        MissionView(mission: mission, astronauts: astronauts)
                    } label: {
                        VStack {
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .padding()

                            VStack {
                                Text(mission.displayName)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Text(mission.formattedLaunchDate)
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.5))
                            }
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(.lightBackground)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.lightBackground)
                        }
                    }

                }
            }
            .padding([.horizontal, .bottom])
        }
    }
}

struct ListLayout: View {
    let astronauts: [String: Astronaut]
    let missions: [Mission]

    var body: some View {
        List(missions, id: \.id) { mission in
            NavigationLink {
                MissionView(mission: mission, astronauts: astronauts)
            } label: {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .padding()

                    VStack {
                        Text(mission.displayName)
                            .font(.headline)
                            .foregroundColor(.white)
                        Text(mission.formattedLaunchDate)
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.5))
                    }
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .background(.lightBackground)
                }
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.lightBackground)
                }
            }
            .listRowBackground(Color.darkBackground)
        }
        .listStyle(.plain)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
