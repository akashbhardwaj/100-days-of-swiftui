//
//  ContentView.swift
//  iExpense
//
//  Created by Akash Bhardwaj on 2023-09-08.
//

import SwiftUI

struct ContentView: View {

    @StateObject private var expenses = Expenses()
    @State private var showingAddExpense = false

    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(expenses.personalItems) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                Text(item.type)
                            }

                            Spacer()
                            ExpenseAmount(amount: item.amount)
                        }
                    }
                    .onDelete(perform: removePersonalItems)
                } header: {
                    Text("Personal")
                }

                Section {
                    ForEach(expenses.businessItems) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                Text(item.type)
                            }

                            Spacer()
                            ExpenseAmount(amount: item.amount)
                        }
                    }
                    .onDelete(perform: removeBusinessItems)
                } header: {
                    Text("Business")
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }

    func removePersonalItems(at offset: IndexSet) {
        expenses.personalItems.remove(atOffsets: offset)
    }

    func removeBusinessItems(at offset: IndexSet) {
        expenses.personalItems.remove(atOffsets: offset)
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct ExpenseAmount: View {

    let amount: Double

    var amountColor: Color {
        if (0.0...10.0).contains(amount) {
            return .green
        } else if (11.0...100.0).contains(amount) {
            return .orange
        } else {
            return .red
        }
    }

    var body: some View {
        Text(amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
            .font(.title2.bold())
            .foregroundColor(amountColor)
    }
}
