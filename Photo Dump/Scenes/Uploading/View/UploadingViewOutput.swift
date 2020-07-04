//
//  UploadingUploadingViewOutput.swift
//  Photo Dump
//
//  Created by Vince Santos on 03/07/2020.
//  Copyright © 2020 Vince Santos. All rights reserved.
//

protocol UploadingViewOutput {

    /**
        @author Vince Santos
        Notify presenter that view is ready
    */

    func viewIsReady()
    func uploadData(imageData: [ImagesDataModel], captionData: [String])
}
