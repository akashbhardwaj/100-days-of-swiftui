//
//  EditView-ViewModel.swift
//  BucketList
//
//  Created by Akash Bhardwaj on 2023-11-29.
//

import Foundation
extension EditView {
    @MainActor class ViewModel: ObservableObject {
        enum LoadingState{
            case loading, loaded, failed
        }

        var location: Location
        var onSave: (Location) -> Void

        @Published var name: String
        @Published var description: String

        @Published var loadingState = LoadingState.loading
        @Published var pages = [Page]()

        init(location: Location, onSave: @escaping (Location) -> Void) {
            self.location = location
            self.name = location.name
            self.description = location.description
            self.onSave = onSave
        }

        func fetchNearbyPlaces() async {
            let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.coordinates.latitude)%7C\(location.coordinates.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"

            guard let url = URL(string: urlString) else {
                print("Bad url")
                return
            }

            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let items = try JSONDecoder().decode(Result.self, from: data)
                pages = items.query.pages.values.sorted()
                loadingState = .loaded
            } catch {
                loadingState = .failed
            }
        }

        func save() {
            var newLocation = location
            newLocation.id = UUID()
            newLocation.name = name
            newLocation.description = description

            onSave(newLocation)
        }
    }
}
