//
//  CachedUser+CoreDataProperties.swift
//  Challenge
//
//  Created by Akash Bhardwaj on 2023-10-31.
//
//

import Foundation
import CoreData


extension CachedUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedUser> {
        return NSFetchRequest<CachedUser>(entityName: "CachedUser")
    }

    @NSManaged public var id: String?
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String?
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var address: String?
    @NSManaged public var about: String?
    @NSManaged public var registered: Date?
    @NSManaged public var tags: String?
    @NSManaged public var friends: NSSet?

    var wrappedId: String {
        id ?? "no id"
    }

    var wrappedName: String {
        name ?? "no Name"
    }

    var wrappedCompany: String {
        company ?? "no company"
    }

    var wrappedEmail: String {
        email ?? "no email"
    }
    var wrappedAbout: String {
        about ?? "No About"
    }
    var wrappedRegistered: Date {
        registered ?? .now
    }
    var wrappedTags: [String] {
        (tags ?? "").components(separatedBy: ",")
    }

    var wrappedAddress: String {
        address ?? "no Address"
    }
    var wrappedFriends: [CachedFriend] {
        let friend = friends as? Set<CachedFriend> ?? []

        return friend.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }

}

// MARK: Generated accessors for friends
extension CachedUser {

    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: CachedFriend)

    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: CachedFriend)

    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)

    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)

}

extension CachedUser : Identifiable {

}
