//
//  ImageSaver.swift
//  InstaFilter
//
//  Created by Akash Bhardwaj on 2023-11-07.
//

import UIKit
class ImageSaver: NSObject {
    var successHandler: (() -> Void)?
    var errorHandler: ((Error) -> Void)?

    init(successHandler: (() -> Void)? = nil, errorHandler: ((Error) -> Void)? = nil) {
        self.successHandler = successHandler
        self.errorHandler = errorHandler
    }

    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }

    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error {
            errorHandler?(error)
        } else {
            successHandler?()
        }
    }
}
