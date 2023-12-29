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
    enum SortType {
        case `default`, alphabetically, country
    }
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    @State private var searchText = ""
    @StateObject var favourites = Favourites()
    @State private var sortType = SortType.default
    @State private var showingSortDailog = false

    var filteredResorts: [Resort] {
        if searchText.isEmpty {
            return resorts
        } else {
            return resorts.filter({
                $0.name.localizedStandardContains(searchText)
            })
        }
    }

    var sortedResorts: [Resort] {
        switch sortType {
        case .default:
            return filteredResorts
        case .alphabetically:
            return filteredResorts.sorted(by: { $0.name < $1.name })
        case .country:
            return filteredResorts.sorted(by: { $0.country < $1.country })
        }
    }

    var body: some View {
        NavigationView {
            List(sortedResorts) { resort in
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
            .toolbar {
                Button {
                    showingSortDailog = true
                } label: {
                    Image(systemName: "1.circle")
                }
            }
            .confirmationDialog("Sort", isPresented: $showingSortDailog) {
                Button("Default") {
                    sortType = .default
                }
                Button("Alphabetically") {
                    sortType = .alphabetically
                }
                Button("Country") {
                    sortType = .country
                }
            }
            WelcomeView()
        }
        .environmentObject(favourites)
    }
}

#Preview {
    ContentView()
}
