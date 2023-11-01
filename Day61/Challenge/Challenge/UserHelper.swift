//
//  UserHelper.swift
//  Challenge
//
//  Created by Akash Bhardwaj on 2023-10-30.
//

import Foundation
class UserHelper {
    init() { }

    func fetchUsers() async -> [User]{
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            fatalError("Not a valid URL")
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let decodedUsers = try decoder.decode([User].self, from: data)
            
            return decodedUsers
        } catch {
            print("Fetching users failed \(error.localizedDescription)")
            return []
        }
    }
}
