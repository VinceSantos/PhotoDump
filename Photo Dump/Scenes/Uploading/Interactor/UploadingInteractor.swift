//
//  UploadingUploadingInteractor.swift
//  Photo Dump
//
//  Created by Vince Santos on 03/07/2020.
//  Copyright © 2020 Vince Santos. All rights reserved.
//
import Foundation
import UIKit

class UploadingInteractor: UploadingInteractorInput {
    
    weak var output: UploadingInteractorOutput!
    
    func processUploadData(imagesData: [ImagesDataModel], captionData: [String]) {
        var localList = [LocalImageData]()
        if let data = UserDefaults.standard.value(forKey:"localData") as? Data {
            let songs2 = try? PropertyListDecoder().decode([LocalImageData].self, from: data)
            for data in songs2! {
                localList.append(LocalImageData(imageUUID: data.imageUUID, imageData: data.imageData, imageDateString: data.imageDateString, caption: data.caption))
            }
        }
        
        for (index, image) in imagesData.enumerated() {
            let dateToday = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM.dd.yyyy"
            let formattedDate = dateFormatter.string(from: dateToday)
            localList.append(LocalImageData(imageUUID: UUID().uuidString, imageData: (image.image?.pngData())!, imageDateString: formattedDate, caption: captionData[index]))
        }
        UserDefaults.standard.set(try? PropertyListEncoder().encode(localList), forKey: "localData")
        output.processedUploadData()
    }
}

//MARK: Entities
struct LocalImageData: Codable {
    var imageUUID: String
    var imageData: Data
    var imageDateString: String
    var caption: String
}
