//
//  UploadingUploadingConfigurator.swift
//  Photo Dump
//
//  Created by Vince Santos on 03/07/2020.
//  Copyright © 2020 Vince Santos. All rights reserved.
//

import UIKit

class UploadingModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? UploadingViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: UploadingViewController) {

        let router = UploadingRouter()

        let presenter = UploadingPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = UploadingInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
