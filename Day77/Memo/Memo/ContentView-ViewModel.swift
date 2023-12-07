//
//  ContentView-ViewModel.swift
//  Memo
//
//  Created by Akash Bhardwaj on 2023-12-05.
//

import UIKit

extension ContentView {
    class ViewModel: ObservableObject {
        @Published var memos: [ImageMemo] = [
            ImageMemo(image: UIImage(systemName: "globe"), name: "Globe")
        ]

        @Published var selectedMemo: [ImageMemo] = []


        let savedPath = FileManager.documentDirectory.appendingPathComponent("memos", isDirectory: true)

        func onImageSelected(image: UIImage?) {
            memos.append(ImageMemo(image: image, name: "Item"))
        }
    }
}
