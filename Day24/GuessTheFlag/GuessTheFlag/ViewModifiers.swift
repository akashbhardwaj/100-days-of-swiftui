//
//  ViewModifiers.swift
//  GuessTheFlag
//
//  Created by Akash Bhardwaj on 2023-08-14.
//

import SwiftUI


struct ProminentFont: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}


extension View {
    func prominentTitle() -> some View {
        modifier(ProminentFont())
    }
}

struct SomeView: View {
    var body: some View {
        Text("Hello World!!!")
            .prominentTitle()
    }
}

struct SomeView_Previews: PreviewProvider {
    static var previews: some View {
        SomeView()
    }
}
