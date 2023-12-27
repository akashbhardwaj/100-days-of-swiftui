//
//  OptionalSheet.swift
//  SnowSeeker
//
//  Created by Akash Bhardwaj on 2023-12-27.
//

import SwiftUI
struct User: Identifiable {
    var id = "Taylor Swift"
}
struct OptionalSheet: View {

    @State private var selectedUser: User? = nil
    @State private var isShowingAlert = false

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .padding()
            .onTapGesture {
                selectedUser = User()
                isShowingAlert = true
            }
//            .sheet(item: $selectedUser) { user in
//                Text(user.id)
//            }
//            .alert("Welcome", isPresented: $isShowingAlert, presenting: selectedUser) { user in
//                Button(user.id) {
//
//                }
//            }
            .alert("Welcome", isPresented: $isShowingAlert) {
            }
    }
}

#Preview {
    OptionalSheet()
}
