//
//  OrderHelper.swift
//  CupcakeCorner
//
//  Created by Akash Bhardwaj on 2023-10-16.
//

import SwiftUI
class OrderHelper: ObservableObject {
    @Published var order = Order()

    init() { }
}
