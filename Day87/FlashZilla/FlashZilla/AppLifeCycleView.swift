//
//  AppLifeCycleView.swift
//  FlashZilla
//
//  Created by Akash Bhardwaj on 2023-12-18.
//

import SwiftUI

struct AppLifeCycleView: View {
    @Environment(\.scenePhase) var scenePhase
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .padding()
            .onChange(of: scenePhase) { oldValue, newValue in
                if newValue == .active {
                    print("Active")
                } else if newValue == .inactive {
                    print("InActive")
                } else {
                    print("background")
                }
            }
    }
}

#Preview {
    AppLifeCycleView()
}
