//
//  FileManager-DocumentsDirectory.swift
//  BucketList
//
//  Created by Akash Bhardwaj on 2023-11-28.
//

import Foundation
extension FileManager {
    static var documentDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
