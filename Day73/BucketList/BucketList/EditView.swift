//
//  EditView.swift
//  BucketList
//
//  Created by Akash Bhardwaj on 2023-11-21.
//

import SwiftUI

struct EditView: View {


    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: ViewModel


    init(location: Location, onSave: @escaping (Location) -> Void) {
        _viewModel = StateObject(wrappedValue: .init(location: location, onSave: onSave))
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Place name", text: $viewModel.name)
                    TextField("Place description", text: $viewModel.description)
                }

                Section("Nearby..") {
                    switch viewModel.loadingState {
                    case .loading:
                        Text("Loading....")
                    case .loaded:
                        ForEach(viewModel.pages, id: \.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                            + Text(":")
                            + Text(page.description)
                                .italic()
                        }
                    case .failed:
                        Text("Please try again later.")
                    }
                }
            }
            .navigationTitle("Place Details")
            .toolbar {
                Button("Save") {
                    viewModel.save()
                    dismiss()
                }
            }
            .task {
                await viewModel.fetchNearbyPlaces()
            }
        }
    }
}

#Preview {
    EditView(location: .example) { _ in

    }
}
