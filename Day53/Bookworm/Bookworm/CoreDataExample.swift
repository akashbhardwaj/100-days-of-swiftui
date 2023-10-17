//
//  CoreDataExample.swift
//  Bookworm
//
//  Created by Akash Bhardwaj on 2023-10-17.
//

import SwiftUI

struct CoreDataExample: View {
    @Environment(\.managedObjectContext) var context
    @FetchRequest(sortDescriptors: []) var students: FetchedResults<Student>


    var body: some View {
        VStack {
            List(students) { student in
                Text(student.name ?? "Unknown")
            }

            Button("Add") {
                let firstName = ["Giny", "Harry", "Hermione", "Ron"]
                let lastName = ["Granger", "Lovegood", "Potter", "Waesley"]
                let chosenFirstName = firstName.randomElement()!
                let chosenLastName = lastName.randomElement()!
                let student = Student(context: context)
                student.id = UUID()
                student.name = "\(chosenFirstName) \(chosenLastName)"

                try? context.save()
            }
        }
    }
}

struct CoreDataExample_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataExample()
    }
}
