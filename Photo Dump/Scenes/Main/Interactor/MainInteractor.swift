//
//  MainMainInteractor.swift
//  Photo Dump
//
//  Created by Vince Santos on 02/07/2020.
//  Copyright © 2020 Vince Santos. All rights reserved.
//
import Foundation
import UIKit

class MainInteractor: MainInteractorInput {

    weak var output: MainInteractorOutput!

    func processLocalData() {
        if let data = UserDefaults.standard.value(forKey:"localData") as? Data {
            let songs2 = try? PropertyListDecoder().decode([LocalImageData].self, from: data)
            var copy2 = [ImagesData]()
            for data in songs2! {
                copy2.append(ImagesData(imageId: data.imageUUID, image: UIImage(data: data.imageData)!, dateString: data.imageDateString, caption: data.caption))
            }
            output.setLocalData(data: copy2)
        }
    }
}

//MARK: Entities
struct ImagesData {
    var imageId: String
    var image: UIImage
    var dateString: String
    var caption: String
}
