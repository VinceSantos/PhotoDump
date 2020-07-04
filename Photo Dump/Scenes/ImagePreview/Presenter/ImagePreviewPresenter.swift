//
//  ImagePreviewImagePreviewPresenter.swift
//  Photo Dump
//
//  Created by Vince Santos on 03/07/2020.
//  Copyright © 2020 Vince Santos. All rights reserved.
//

class ImagePreviewPresenter: ImagePreviewModuleInput, ImagePreviewViewOutput, ImagePreviewInteractorOutput {

    weak var view: ImagePreviewViewInput!
    var interactor: ImagePreviewInteractorInput!
    var router: ImagePreviewRouterInput!

    func viewIsReady() {

    }
    
    func deleteData(imageData: ImagesData) {
        interactor.processDeleteData(imageData: imageData)
    }
    
    func processedDeleteData() {
        view.deletedData()
    }
}
