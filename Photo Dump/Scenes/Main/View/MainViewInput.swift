//
//  MainMainViewInput.swift
//  Photo Dump
//
//  Created by Vince Santos on 02/07/2020.
//  Copyright © 2020 Vince Santos. All rights reserved.
//

protocol MainViewInput: class {

    /**
        @author Vince Santos
        Setup initial state of the view
    */

    func setupInitialState()
    func getLocalData(data: [ImagesData])
}
