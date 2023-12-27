//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by Akash Bhardwaj on 2023-09-15.
//

import Foundation

extension Bundle {
    func decode<`Type`: Decodable>(_ file: String) -> `Type` {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("failed to locate \(file) in bundle")
        }
        guard let data = try? Data(contentsOf: url) else {
            fatalError("failed to load \(file) from bundle")
        }
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)

        guard let loaded = try? decoder.decode(`Type`.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle")
        }
        return loaded
    }
}


