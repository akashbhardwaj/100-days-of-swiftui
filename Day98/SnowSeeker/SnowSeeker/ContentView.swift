//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Akash Bhardwaj on 2023-12-27.
//

import SwiftUI
extension View {
    @ViewBuilder func phoneOnlyNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.navigationViewStyle(.stack)
        } else {
            self
        }
    }
}

struct ContentView: View {
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    @State private var searchText = ""
    @StateObject var favourites = Favourites()

    var filteredResorts: [Resort] {
        if searchText.isEmpty {
            return resorts
        } else {
            return resorts.filter({
                $0.name.localizedStandardContains(searchText)
            })
        }
    }

    var body: some View {
        NavigationView {
            List(filteredResorts) { resort in
                NavigationLink {
                    ResortView(resort: resort)
                } label: {
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            .overlay {
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                            }

                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .foregroundStyle(.secondary)
                        }

                        if favourites.contains(resort) {
                            Spacer()

                            Image(systemName: "heart.fill")
                                .accessibilityLabel("This is a favourite resort")
                                .foregroundStyle(.red)
                        }
                    }
                }
            }
            .searchable(text: $searchText, prompt: "Search for a resort")
            .navigationTitle("Resorts")
            WelcomeView()
        }
        .environmentObject(favourites)
    }
}

#Preview {
    ContentView()
}
