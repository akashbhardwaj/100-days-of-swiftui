//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Akash Bhardwaj on 2023-10-06.
//

import SwiftUI
struct ContentView: View {
    @StateObject var orderHelper = OrderHelper()

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select you cake type", selection: $orderHelper.order
                        .type) {
                            ForEach(Order.types.indices) {
                                Text(Order.types[$0])
                            }
                        }
                    Stepper("Number of cakes: \(orderHelper.order.quantity)", value: $orderHelper.order.quantity, in: 3...20)
                }

                Section {
                    Toggle("Any special request", isOn: $orderHelper.order.specialRequestEnabled.animation())

                    if orderHelper.order.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $orderHelper.order.extraFrosting)
                        Toggle("Add extra sprinkles", isOn: $orderHelper.order.addSprinkles)

                    }
                }

                Section {
                    NavigationLink {
                        AddressView(orderHelper: orderHelper)
                    } label: {
                        Text("Deliver Details")
                    }
                }
            }
            .navigationTitle("Cupcake Center")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

