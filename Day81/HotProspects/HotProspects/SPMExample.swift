//
//  SPMExample.swift
//  HotProspects
//
//  Created by Akash Bhardwaj on 2023-12-12.
//

import SamplePackage
import SwiftUI

struct SPMExample: View {
    let possibleNumbers = Array(1...60)

    var body: some View {
        Text(results)
    }

    var results: String {
        let selected = possibleNumbers.random(7).sorted()
        let strings = selected.map(String.init)
        return strings.joined(separator: ", ")
    }
}

#Preview {
    SPMExample()
}
