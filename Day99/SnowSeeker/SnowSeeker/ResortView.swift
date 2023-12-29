//
//  ResortView.swift
//  SnowSeeker
//
//  Created by Akash Bhardwaj on 2023-12-27.
//

import SwiftUI

struct ResortView: View {
    let resort: Resort
    @Environment(\.horizontalSizeClass) private var sizeClass
    @Environment(\.dynamicTypeSize) private var typeSize
    @EnvironmentObject private var favourites: Favourites

    @State private var selectedFacility: Facility?
    @State private var isShowingFacility = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                ZStack(alignment: .bottomTrailing) {
                    Image(decorative: resort.id)
                        .resizable()
                        .scaledToFit()
                    Text("Credits: \(resort.imageCredit)")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                HStack {
                    if sizeClass == .compact && typeSize > .large {
                        VStack(spacing: 10) {
                            ResortDetailsView(resort: resort)
                        }
                        VStack(spacing: 10) {
                            SkiDetailsView(resort: resort)

                        }
                    } else {
                        ResortDetailsView(resort: resort)
                        SkiDetailsView(resort: resort)
                    }
                }
                .padding(.vertical)
                .background(.primary.opacity(0.1))
                .dynamicTypeSize(...DynamicTypeSize.xxxLarge)

                Group {
                    Text(resort.description)
                        .padding(.vertical)

                    Text("Facilities")
                        .font(.headline)

                    HStack {
                        ForEach(resort.facilityTypes) { facility in
                            Button {
                                selectedFacility = facility
                                isShowingFacility = true
                            } label: {
                                facility.icon
                                    .font(.title)
                            }
                        }
                    }

                    Button(favourites.contains(resort) ? "Remove from Favourites" : "Add to favourites") {
                        if favourites.contains(resort) {
                            favourites.remove(resort)
                        } else {
                            favourites.add(resort)
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .padding()
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle("\(resort.name), \(resort.country)")
        .navigationBarTitleDisplayMode(.inline)
        .alert(selectedFacility?.name ?? "More information", isPresented: $isShowingFacility, presenting: selectedFacility) { _ in
        } message: { facility in
            Text(facility.description)
        }
    }
}

#Preview {
    NavigationView {
        ResortView(resort: .example)
    }
    .environmentObject(Favourites())
}
