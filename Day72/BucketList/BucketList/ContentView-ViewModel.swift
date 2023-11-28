//
//  ContentView-ViewModel.swift
//  BucketList
//
//  Created by Akash Bhardwaj on 2023-11-28.
//

import Foundation
import LocalAuthentication
import MapKit
extension ContentView {

    @MainActor class ViewModel: ObservableObject {
        @Published var mapRegion: MKCoordinateRegion
        @Published private(set) var locations: [Location]
        @Published var selectedPlace: Location?
        @Published var isUnlocked = false

        let savePath = FileManager.documentDirectory.appendingPathComponent("SavedPlaces")

        init() {
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch {
                locations = []
            }
            mapRegion = MKCoordinateRegion(center: .init(latitude: 50, longitude: 0), span: .init(latitudeDelta: 25, longitudeDelta: 25))
        }

        func save() {
            do  {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomicWrite, .completeFileProtection])
            } catch {
                print("unable to save data")
            }
        }

        func addLocation() {
            let newLocation = Location(id: .init(), name: "New Location", description: "", latitude: mapRegion.center.latitude, longitude: mapRegion.center.longitude)
            locations.append(newLocation)
            save()
        }

        func update(location: Location) {
            guard let selectedPlace else { return }
            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = location
            }
            save()
        }

        func authenticate() {
            let context = LAContext()
            var error: NSError?

            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Please authenticate yourself to unlock your places"

                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, error in
                    if success {
                        Task { @MainActor in
                            self.isUnlocked = true
                        }
                    } else {
                        // Error
                    }
                }
            } else {
                // No biometrics
            }
        }
    }
}
