//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Akash Bhardwaj on 2023-10-26.
//

import CoreData
import SwiftUI
enum Predicate {
    case equals(String)
    case beginsWith(String)
    case smallerThan(String)
    case smallerThanEqualTo(String)
    case greaterThan(String)
    case greaterThanEqualTO(String)

    var predicate: String {
        switch self {
        case .beginsWith(let filter):
            return "%K BEGINSWITH \"\(filter)\""
        case .equals(let filter):
            return "%K == \"\(filter)\""
        case .smallerThan(let filter):
            return "%K < \"\(filter)\""
        case .smallerThanEqualTo(let filter):
            return "%K <= \"\(filter)\""
        case .greaterThan(let filter):
            return "%K > \"\(filter)\""
        case .greaterThanEqualTO(let filter):
            return "%K >= \"\(filter)\""
        }
    }

    var value: String {
        switch self {
        case .beginsWith(let filter), .equals(let filter), .smallerThan(let filter), .smallerThanEqualTo(let filter), .greaterThan(let filter), .greaterThanEqualTO(let filter):
            return filter
        }
    }
}

struct FilteredList<T: NSManagedObject, Content: View>: View {
    @FetchRequest var fetchRequest: FetchedResults<T>

    @ViewBuilder
    let content: (T) -> Content

    var body: some View {
        List(fetchRequest, id: \.self) { item in
            content(item)
        }
    }

    init(sortDescriptors: [SortDescriptor<T>] = [], filterKey: String, filter: Predicate, @ViewBuilder content: @escaping (T) -> Content) {

        _fetchRequest = FetchRequest<T>(sortDescriptors: sortDescriptors as? [NSSortDescriptor] ?? [], predicate: NSPredicate(format: filter.predicate, filterKey))
        self.content = content
    }
}

