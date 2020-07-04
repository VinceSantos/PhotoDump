//
//  ImagePreviewImagePreviewConfigurator.swift
//  Photo Dump
//
//  Created by Vince Santos on 03/07/2020.
//  Copyright © 2020 Vince Santos. All rights reserved.
//

import UIKit

class ImagePreviewModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? ImagePreviewViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: ImagePreviewViewController) {

        let router = ImagePreviewRouter()

        let presenter = ImagePreviewPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = ImagePreviewInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
