//
//  Biometrics.swift
//  BucketList
//
//  Created by Akash Bhardwaj on 2023-11-20.
//

import LocalAuthentication
import SwiftUI

struct Biometrics: View {
    @State private var isUnlocked = false

    var body: some View {
        VStack {
            if isUnlocked {
                Text("Unlocked")
            } else {
                Text("Locked")
            }
        }
        .onAppear(perform: authenticate)

    }

    func authenticate() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let touchIdReason = "We need to unlock your data"

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: touchIdReason) { success, authenticationError  in
                
                if success {
                    isUnlocked = true
                } else {
                    // Error
                }
            }
        } else {
            // No biometrics enrolled
        }
    }
}

#Preview {
    Biometrics()
}
