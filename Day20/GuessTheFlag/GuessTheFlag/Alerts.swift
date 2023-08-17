//
//  Alerts.swift
//  GuessTheFlag
//
//  Created by Akash Bhardwaj on 2023-08-04.
//

import SwiftUI

struct Alerts: View {

    @State private var showingAlert = false

    var body: some View {
        NavigationView {
            Button("Show alert!!") {
                showingAlert = true
            }
            .alert("Important message", isPresented: $showingAlert) {
                Button("Ok", role: .destructive) { }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("Please read this")
            }
        }
    }
}

struct Alerts_Previews: PreviewProvider {
    static var previews: some View {
        Alerts()
    }
}
