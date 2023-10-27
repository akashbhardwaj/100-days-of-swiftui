//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Akash Bhardwaj on 2023-10-24.
//

import CoreData
import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: ShipList()) {
                    Text("Ships")
                }
                NavigationLink(destination: DynamicFilterExample()){
                    Text("Dynamic Filter")
                }
                NavigationLink(destination: RelationShips()){
                    Text("RelationShips")
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ShipList: View {
    @Environment(\.managedObjectContext) var context
//    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "universe IN %@", ["Stat Trek"])) var ships: FetchedResults<Ship>
    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "NOT name BEGINSWITH[c] %@", "e")) var ships: FetchedResults<Ship>

    var body: some View {
        VStack {
            List (ships, id: \.self) { ship in
                Text(ship.name ?? "Unknown ship")
            }
            Button ("Add Examples") {
                let ship1 = Ship(context: context)
                ship1.name = "Enterprise"
                ship1.universe = "Stat Trek"

                let ship2 = Ship(context: context)
                ship2.name = "Defiant"
                ship2.universe = "Stat Trek"

                let ship3 = Ship(context: context)
                ship3.name = "Millenium Falcon"
                ship3.universe = "Stat Wars"

                let ship4 = Ship(context: context)
                ship4.name = "Executor"
                ship4.universe = "Stat Wars"

                try? context.save()
            }
        }
    }
}



struct DynamicFilterExample: View {
    @Environment(\.managedObjectContext) var context
    @State private var lastNameFilter = "A"

    var body: some View {
        VStack {
            FilteredList(sortDescriptors: [SortDescriptor(\.lastName, order: .reverse)] ,filterKey: "lastName", filter: .greaterThan(lastNameFilter)) { (singer: Singer) in
                Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
            }
            Button("Add example") {
                let taylor = Singer(context: context)
                taylor.firstName = "Taylor"
                taylor.lastName = "Swift"

                let ed = Singer(context: context)
                ed.firstName = "Ed"
                ed.lastName = "Sheeran"

                let adele = Singer(context: context)
                adele.firstName = "Adele"
                adele.lastName = "Adkins"

                try? context.save()
            }

            Button ("Show A") {
                lastNameFilter = "A"
            }

            Button("Show S") {
                lastNameFilter = "S"
            }
        }
    }
}



struct RelationShips: View {
    @Environment(\.managedObjectContext) var context
    @FetchRequest(sortDescriptors: []) var countries: FetchedResults<Country>

    var body: some View {
        VStack {
            List {
                ForEach(countries, id: \.self) { country in
                    Section(country.wrappedFullName) {
                        ForEach(country.candyArray, id: \.self) { candy in
                            Text(candy.wrappedName)
                        }
                    }
                }
            }
            Button("Add Example") {
                let candy1 = Candy(context: context)
                candy1.name = "Mars"
                candy1.origin = Country(context: context)
                candy1.origin?.shortName = "UK"
                candy1.origin?.fullName = "United Kingdom"

                let candy2 = Candy(context: context)
                candy2.name = "Kit Kat"
                candy2.origin = Country(context: context)
                candy2.origin?.shortName = "UK"
                candy2.origin?.fullName = "United Kingdom"

                let candy3 = Candy(context: context)
                candy3.name = "Twix"
                candy3.origin = Country(context: context)
                candy3.origin?.shortName = "UK"
                candy3.origin?.fullName = "United Kingdom"

                let candy4 = Candy(context: context)
                candy4.name = "Toblerone"
                candy4.origin = Country(context: context)
                candy4.origin?.shortName = "CH"
                candy4.origin?.fullName = "Switzerland"

                try? context.save()
            }
        }
    }
}
