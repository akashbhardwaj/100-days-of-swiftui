//
//  ContentView.swift
//  WeSplit
//
//  Created by Akash Bhardwaj on 2023-07-31.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedStudent = ""
    let students = ["Harry", "Herminoe", "Ron"]
    var body: some View {
        Form {
            Picker("Select you student", selection: $selectedStudent) {
                ForEach(students, id: \.self) {
                    Text("\($0)")
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
