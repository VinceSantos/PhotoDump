//
//  UploadingUploadingPresenter.swift
//  Photo Dump
//
//  Created by Vince Santos on 03/07/2020.
//  Copyright © 2020 Vince Santos. All rights reserved.
//

class UploadingPresenter: UploadingModuleInput, UploadingViewOutput, UploadingInteractorOutput {
    weak var view: UploadingViewInput!
    var interactor: UploadingInteractorInput!
    var router: UploadingRouterInput!

    func viewIsReady() {

    }
    
    func uploadData(imageData: [ImagesDataModel], captionData: [String]) {
        interactor.processUploadData(imagesData: imageData, captionData: captionData)
    }
    
    func processedUploadData() {
        view.uploadDone()
    }
}
