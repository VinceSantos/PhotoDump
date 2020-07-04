//
//  MainMainPresenter.swift
//  Photo Dump
//
//  Created by Vince Santos on 02/07/2020.
//  Copyright © 2020 Vince Santos. All rights reserved.
//

class MainPresenter: MainModuleInput, MainViewOutput, MainInteractorOutput {

    weak var view: MainViewInput!
    var interactor: MainInteractorInput!
    var router: MainRouterInput!

    func viewIsReady() {

    }
    
    func showImageLibrary() {
        router.pushImageLibrary()
    }
    
    func showImage(image: ImagesDataModel) {
        router.pushImage(image: image)
    }
    
    func loadLocalData() {
        interactor.processLocalData()
    }
    
    func setLocalData(data: [ImagesData]) {
        view.getLocalData(data: data)
    }
}
