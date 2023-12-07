//
//  EditView.swift
//  Memo
//
//  Created by Akash Bhardwaj on 2023-12-05.
//

import SwiftUI

struct EditView: View {
    let memo: ImageMemo
    @State private var name = ""

    init(memo: ImageMemo) {
        self.memo = memo
        _name = State(initialValue: memo.name)
    }

    var body: some View {
        NavigationView {
            VStack {
                if let image = memo.image {
                    Image(uiImage: image)
                        .resizable()
                        .frame(height: 250)
                } else {
                    Text("Image Unavailable")
                }
                TextField("Name", text: $name)
                    .font(.title)
                Spacer()
            }
            .padding([.horizontal])
            .navigationTitle("Edit Memo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button {
                    
                } label: {
                    Image(systemName: "opticaldiscdrive")
                }
            }

        }
    }
}

#Preview {
    EditView(memo: ImageMemo(image: UIImage(systemName: "globe"), name: "Globe"))
}
