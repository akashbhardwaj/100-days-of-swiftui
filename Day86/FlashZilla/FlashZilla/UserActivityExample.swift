//
//  UserActivityExample.swift
//  FlashZilla
//
//  Created by Akash Bhardwaj on 2023-12-17.
//

import SwiftUI

struct UserActivityExample: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.blue)
                .frame(width: 300, height: 300)
                .onTapGesture {
                    print("Rectangle")
                }

            Circle()
                .fill(.red)
                .frame(width: 300, height: 300)
            // To change area for tap
                .contentShape(Rectangle())
                .onTapGesture {
                    print("circle")
                }
                //.allowsHitTesting(false)
        }
    }
}

#Preview {
    UserActivityExample()
}

struct UserActivityExample2: View {
    var body: some View {
        VStack {
            Text("Some thing")
            Spacer().frame(height: 100)
            Text("Bottom")
        }
        .contentShape(Rectangle())
        .onTapGesture {
            print("Tapped")
        }
    }
}

#Preview {
    UserActivityExample2()
}
