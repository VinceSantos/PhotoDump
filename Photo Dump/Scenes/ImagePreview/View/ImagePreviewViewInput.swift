//
//  ImagePreviewImagePreviewViewInput.swift
//  Photo Dump
//
//  Created by Vince Santos on 03/07/2020.
//  Copyright © 2020 Vince Santos. All rights reserved.
//

protocol ImagePreviewViewInput: class {

    /**
        @author Vince Santos
        Setup initial state of the view
    */

    func setupInitialState()
    func deletedData()
}
