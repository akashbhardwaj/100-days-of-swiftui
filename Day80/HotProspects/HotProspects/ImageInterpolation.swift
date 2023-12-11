//
//  ImageInterpolation.swift
//  HotProspects
//
//  Created by Akash Bhardwaj on 2023-12-11.
//

import SwiftUI

struct ImageInterpolation: View {
    var body: some View {
        Image("example")
            .interpolation(.none)
            .resizable()
            .scaledToFit()
            .frame(maxHeight: .infinity)
            .background(.black)
            .ignoresSafeArea()
    }
}

#Preview {
    ImageInterpolation()
}
