//
//  Expenses.swift
//  iExpense
//
//  Created by Akash Bhardwaj on 2023-09-11.
//

import Foundation

class Expenses: ObservableObject {
    @Published var personalItems = [ExpenseItem]() {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(personalItems) {
                UserDefaults.standard.set(encoded, forKey: "personal_items")
            }
        }
    }

    @Published var businessItems = [ExpenseItem]() {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(businessItems) {
                UserDefaults.standard.set(encoded, forKey: "business_items")
            }
        }
    }

    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "personal_items"),
            let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                personalItems = decodedItems
        } else {
            personalItems = []
        }

        if let savedItems = UserDefaults.standard.data(forKey: "business_items"),
            let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                personalItems = decodedItems
        } else {
            personalItems = []
        }
    }
}
