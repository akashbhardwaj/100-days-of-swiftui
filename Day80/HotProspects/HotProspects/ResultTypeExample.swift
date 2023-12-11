//
//  ResultTypeExample.swift
//  HotProspects
//
//  Created by Akash Bhardwaj on 2023-12-11.
//

import SwiftUI

struct ResultTypeExample: View {
    @State private var output = ""

    var body: some View {
        Text(output)
            .task {
                await fetchReadings()
            }
    }

    func fetchReadings() async {
        let fetchTask = Task { () -> String in
            let url = URL(string: "http://hws.dev/readings.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let readings = try JSONDecoder().decode([Double].self, from: data)
            return "Found \(readings.count) readings"
        }

        let result = await fetchTask.result

        switch result {
        case .success(let readings):
            output = readings
        case .failure(let error):
            output = error.localizedDescription
        }
    }
}

#Preview {
    ResultTypeExample()
}
