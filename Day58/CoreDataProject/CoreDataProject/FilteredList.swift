//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Akash Bhardwaj on 2023-10-26.
//

import CoreData
import SwiftUI

struct FilteredList<T: NSManagedObject, Content: View>: View {
    @FetchRequest var fetchRequest: FetchedResults<T>

    @ViewBuilder
    let content: (T) -> Content

    var body: some View {
        List(fetchRequest, id: \.self) { item in
            content(item)
        }
    }

    init(filterKey: String, filter: String, @ViewBuilder content: @escaping (T) -> Content) {
        _fetchRequest = FetchRequest<T>(sortDescriptors: [], predicate: NSPredicate(format: "%K BEGINSWITH %@", filterKey, filter))
        self.content = content
    }
}

