//
//  CachedFriend+CoreDataProperties.swift
//  Challenge
//
//  Created by Akash Bhardwaj on 2023-10-31.
//
//

import Foundation
import CoreData


extension CachedFriend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedFriend> {
        return NSFetchRequest<CachedFriend>(entityName: "CachedFriend")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var user: CachedUser?

    var wrappedId: String {
        id ?? "no id"
    }

    var wrappedName: String {
        name ?? "No name"
    }


}

extension CachedFriend : Identifiable {

}
