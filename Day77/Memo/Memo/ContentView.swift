//
//  ContentView.swift
//  Memo
//
//  Created by Akash Bhardwaj on 2023-12-05.
//

import SwiftUI
struct ImageMemo: Identifiable {
    let id = UUID()
    var image: UIImage?
    var name: String
}
struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    @State private var showingImagePicker = false

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.memos) { memo in
                    NavigationLink {
                        EditView(memo: memo)
                    } label: {
                        HStack {
                            if let uiImage = memo.image {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .frame(width: 44, height: 44)
                                    .cornerRadius(4)
                            } else {
                                Text("Image Unavaliable")
                            }
                            Text(memo.name)
                        }
                    }
                }
            }
            .navigationTitle("Image Memo")
            .toolbar {
                Button {
                    showingImagePicker = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker { image in
                    viewModel.onImageSelected(image: image)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
