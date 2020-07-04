//
//  MainMainViewOutput.swift
//  Photo Dump
//
//  Created by Vince Santos on 02/07/2020.
//  Copyright © 2020 Vince Santos. All rights reserved.
//

protocol MainViewOutput {

    /**
        @author Vince Santos
        Notify presenter that view is ready
    */

    func viewIsReady()
    func showImageLibrary()
    func showImage(image: ImagesDataModel)
    func loadLocalData()
}
