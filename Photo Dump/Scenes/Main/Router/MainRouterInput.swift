//
//  MainMainRouterInput.swift
//  Photo Dump
//
//  Created by Vince Santos on 02/07/2020.
//  Copyright © 2020 Vince Santos. All rights reserved.
//

import Foundation

protocol MainRouterInput {
    func pushImageLibrary()
    func pushImage(image: ImagesDataModel)
}
