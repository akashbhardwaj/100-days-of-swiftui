//
//  CustomAlignmentGuide.swift
//  LayoutAndGeometry
//
//  Created by Akash Bhardwaj on 2023-12-21.
//

import SwiftUI

extension VerticalAlignment {
    enum MidAccountAndName: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[.top]
        }
    }

    static let midAccountAndName =  VerticalAlignment(MidAccountAndName.self)
}

struct CustomAlignmentGuide: View {
    var body: some View {
        HStack(alignment: .midAccountAndName) {
            VStack {
                Text("SomeiOSDev")
                    .alignmentGuide(.midAccountAndName) { d in
                        d[VerticalAlignment.center]
                    }
                Image("example")
                    .resizable()
                    .frame(width: 64, height: 64)
            }

            VStack {
                Text("Akash Bhardwaj")
                    .font(.largeTitle)
                    .alignmentGuide(.midAccountAndName) { d in
                        d[VerticalAlignment.center]
                    }
            }
        }
    }
}

#Preview {
    CustomAlignmentGuide()
}
