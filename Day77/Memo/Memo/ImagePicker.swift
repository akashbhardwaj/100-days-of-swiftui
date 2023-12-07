//
//  ImagePicker.swift
//  Memo
//
//  Created by Akash Bhardwaj on 2023-12-05.
//

import SwiftUI
import PhotosUI

struct ImagePicker: UIViewControllerRepresentable {
    var onImageSelection: (UIImage?) -> Void

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var parent: ImagePicker
        init(parent: ImagePicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            
            guard let provider = results.first?.itemProvider else {
                return
            }

            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { [self] image, _ in
                    if let image {
                        parent.onImageSelection(image as? UIImage)
                    }
                }
            }
        }

    }

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images

        let picturePickerVc = PHPickerViewController(configuration: configuration)
        picturePickerVc.delegate = context.coordinator
        return picturePickerVc
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {

    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }


}
