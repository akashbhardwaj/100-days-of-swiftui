//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Akash Bhardwaj on 2023-09-11.
//

import Foundation
struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
