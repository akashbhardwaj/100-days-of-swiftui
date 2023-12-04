//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Akash Bhardwaj on 2023-10-11.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var orderHelper: OrderHelper
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $orderHelper.order.name)
                TextField("Street Address", text: $orderHelper.order.streetAddress)
                TextField("City", text: $orderHelper.order.city)
                TextField("Zip", text: $orderHelper.order.zip)
            }
            Section {
                NavigationLink {
                    CheckoutView(orderHelper: orderHelper)
                } label: {
                    Text("Checkout")
                }
            }
            .disabled(orderHelper.order.hasValidAddress == false)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddressView(orderHelper: OrderHelper())
        }
    }
}
