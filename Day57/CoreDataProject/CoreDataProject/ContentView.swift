//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Akash Bhardwaj on 2023-10-24.
//

import SwiftUI

struct Student: Hashable {
    let name: String
}

struct ContentView: View {
    @Environment(\.managedObjectContext) var context
    let students = [Student(name: "Harry Potter"), Student(name: "Ron Weasley")]
    var body: some View {
//        VStack {
//            List(students, id: \.self) { student in
//                Text("Name: \(student.name)")
//            }
//            Button("Save") {
//                if context.hasChanges {
//                    try? context.save()
//                }
//            }
//        }
        WizardView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct WizardView: View {
    @Environment(\.managedObjectContext) var context
    @FetchRequest(sortDescriptors: []) var wizards: FetchedResults<Wizard>
    var body: some View {
        List(wizards, id: \.self) { wizard in
            Text(wizard.name ?? "Unknown")
        }
        Button ("Add") {
            let wizard = Wizard(context: context)
            wizard.name = "Harry Potter"
        }
        Button("Save") {
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }

}

