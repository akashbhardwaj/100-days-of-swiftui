//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Akash Bhardwaj on 2023-10-06.
//

import SwiftUI
struct ContentView: View {
    @StateObject var order = Order()

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select you cake type", selection: $order
                        .type) {
                            ForEach(Order.types.indices) {
                                Text(Order.types[$0])
                            }
                        }
                    Stepper("Number of cakes: \(order.quantity)", value: $order.quantity, in: 3...20)
                }

                Section {
                    Toggle("Any special request", isOn: $order.specialRequestEnabled.animation())

                    if order.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $order.extraFrosting)
                        Toggle("Add extra sprinkles", isOn: $order.addSprinkles)

                    }
                }

                Section {
                    NavigationLink {
                        AddressView(order: order)
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

