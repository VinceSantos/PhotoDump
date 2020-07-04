//
//  ImagePreviewImagePreviewInteractor.swift
//  Photo Dump
//
//  Created by Vince Santos on 03/07/2020.
//  Copyright © 2020 Vince Santos. All rights reserved.
//
import Foundation

class ImagePreviewInteractor: ImagePreviewInteractorInput {
    weak var output: ImagePreviewInteractorOutput!

    func processDeleteData(imageData: ImagesData) {
        var localList = [LocalImageData]()
        if let data = UserDefaults.standard.value(forKey:"localData") as? Data {
            let songs2 = try? PropertyListDecoder().decode([LocalImageData].self, from: data)
            for data in songs2! {
                if imageData.imageId != data.imageUUID {
                    localList.append(LocalImageData(imageUUID: data.imageUUID, imageData: data.imageData, imageDateString: data.imageDateString, caption: data.caption))
                }
            }
        }
        UserDefaults.standard.set(try? PropertyListEncoder().encode(localList), forKey: "localData")
        output.processedDeleteData()
    }
}
