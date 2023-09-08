//
//  ContentView.swift
//  iExpense
//
//  Created by Akash Bhardwaj on 2023-09-08.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
//        UserView()
//        SheetView()
//        DeleteRowsView()
//        StoringUserSettings()
        ArchingSwiftObject()
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
// State Objects
// the Text will not change as it is a class and the User instance is not changing
class User: ObservableObject {
    @Published var firstName = "Bilbo"
    @Published var lastName = "Baggins"
}

struct UserView: View {
    @StateObject var user = User()

    var body: some View {
        VStack {
            Text("Your name is \(user.firstName) \(user.lastName)")

            TextField("First Name", text: $user.firstName)
            TextField("First Name", text: $user.lastName)
        }
        .padding()
    }
}

// Show hide views
struct SheetView: View {
    @State private var showingSheet = false
    var body: some View {
        Button("Show Sheet") {
            showingSheet.toggle()
        }
        .sheet(isPresented: $showingSheet) {
            SecondView(name: "Bilbo Baggins")
        }
    }
}
struct SecondView: View {
    @Environment(\.dismiss) var dismiss
    let name: String

    var body: some View {
        VStack {
            Text("Hello \(name)")

            Button("Dismiss") {
                dismiss()
            }
        }
    }
}

// MARK: Delete rows
struct DeleteRowsView: View {
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(numbers, id: \.self) { number in
                        Text("Row \(number)")
                    }
                    .onDelete(perform: removeRows)
                }
                Button("Add Number") {
                    numbers.append(currentNumber)
                    currentNumber += 1
                }
            }
            .navigationTitle("onDelete")
            .toolbar {
                EditButton()
            }
        }
    }

    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
}


// MARK: Storing User Settings // @AppStorage
struct StoringUserSettings: View {
    //    @State private var tapCount = UserDefaults.standard.integer(forKey: "tap")

    @AppStorage("tap") private var tapCount = 0

    var body: some View {
        Button("Tap count \(tapCount)") {
            tapCount += 1
            //UserDefaults.standard.set(tapCount, forKey: "tap")
        }
    }
}

// MARK: Archiving Swift Object
struct User2: Codable {
    let firstName: String
    let lastName: String
}

struct ArchingSwiftObject: View {

    @State private var user = User2(firstName: "Bilbo", lastName: "Baggins")

    var body: some View {
        Button("Save User") {
            let encoder = JSONEncoder()
            if let data = try? encoder.encode(user) {
                UserDefaults.standard.set(data, forKey: "user2")
            }
        }
    }
}
