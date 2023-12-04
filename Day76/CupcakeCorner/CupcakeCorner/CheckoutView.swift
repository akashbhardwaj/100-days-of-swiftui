//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Akash Bhardwaj on 2023-10-11.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var orderHelper: OrderHelper
    @State private var confirmationMessage = ""
    @State private var isShowingConfirmation = false
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image.resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                .accessibilityHidden(true)

                Text("Your total is \(orderHelper.order.cost, format: .currency(code: "USD"))")

                Button("Place Order", action: {
                    Task {
                        await placeOrder()
                    }
                })
                .padding()
            }
            .navigationTitle("Check out")
            .navigationBarTitleDisplayMode(.inline)
            .alert("Thank you!", isPresented: $isShowingConfirmation) {
                Button("Ok") {}
            } message: {
                Text(confirmationMessage)
            }
        }
    }

    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(orderHelper.order) else {
            print("Failed to encode order")
            return
        }

        let url = URL(string: "https://reqres.in/api/cupcakes")!

        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"

        do  {
            let (data,_) = try await URLSession.shared.upload(for: request, from: encoded)
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.quantity)x\(Order.types[decodedOrder.type]) cupcakes is on its way"
            isShowingConfirmation = true
        } catch {
            confirmationMessage = "\(error.localizedDescription)"
            isShowingConfirmation = true
            print("Checkout failed \(error.localizedDescription)")
        }

    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CheckoutView(orderHelper: OrderHelper())
        }
    }
}
