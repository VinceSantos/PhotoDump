//
//  MainMainRouter.swift
//  Photo Dump
//
//  Created by Vince Santos on 02/07/2020.
//  Copyright © 2020 Vince Santos. All rights reserved.
//
import UIKit

class MainRouter: MainRouterInput {
    
    var viewController: MainViewController!
    
    func pushImageLibrary() {
        viewController.navigationController?.pushViewController(AttachmentHandlerViewController(), animated: true)
    }
    
    func pushImage(image: ImagesDataModel) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: String(describing: UploadingViewController.self)) as! UploadingViewController
        vc.listPhotos.append(image)
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
}
