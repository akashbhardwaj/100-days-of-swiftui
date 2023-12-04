//
//  AddView.swift
//  iExpense
//
//  Created by Akash Bhardwaj on 2023-09-11.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var expenses: Expenses
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    @Environment(\.dismiss) var dismiss
    

    let types = ["Business", "Personal"]

    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)

                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }

                TextField("Amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)

            }
            .toolbar {
                Button("Save") {
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    if type == "Personal" {
                        expenses.personalItems.append(item)
                    } else {
                        expenses.businessItems.append(item)
                    }
                    dismiss()
                }
            }
            .navigationTitle("Add new expense")
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
