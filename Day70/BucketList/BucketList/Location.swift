//
//  Location.swift
//  BucketList
//
//  Created by Akash Bhardwaj on 2023-11-21.
//

import Foundation
import CoreLocation
struct Location: Identifiable, Equatable, Codable {
    var id: UUID
    var name: String
    var description: String
    var latitude: Double
    var longitude: Double

    var coordinates: CLLocationCoordinate2D {
        .init(latitude: latitude, longitude: longitude)
    }

    static let example = Location(id: UUID(), name: "Buckingham Palace", description: "where Queen Elizabeth lives with her dorgis", latitude: 51.50, longitude: -0.141)

    static func ==(lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}
