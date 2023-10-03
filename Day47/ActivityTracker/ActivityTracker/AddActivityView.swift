//
//  AddActivityView.swift
//  ActivityTracker
//
//  Created by Akash Bhardwaj on 2023-10-03.
//

import SwiftUI

struct AddActivityView: View {
    @State private var name = ""
    @State private var description = ""

    @Environment(\.dismiss) private var dismiss

    let onAddActivity: (Activity) -> Void

    var body: some View {

        VStack {
            Spacer()
            VStack(spacing: 10) {
                TextField("Name", text: $name)
                    .textFieldStyle(.roundedBorder)
                TextField("Description", text: $description)
                    .textFieldStyle(.roundedBorder)
                    .padding([.bottom], 20)

                Button {
                    onAddActivity(Activity(name: name, description: description, count: 0))
                    dismiss()
                } label: {
                    Image(systemName: "plus")
                        .padding()
                        .foregroundColor(.white)
                        .background {
                            Circle()
                                .fill(.blue)
                        }
                }
            }
            Spacer()
            Spacer()
        }
        .padding([.horizontal], 20)

    }
}

struct AddActivityView_Previews: PreviewProvider {
    static var previews: some View {
        AddActivityView { _ in

        }
    }
}
