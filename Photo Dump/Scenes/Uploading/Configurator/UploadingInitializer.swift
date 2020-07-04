//
//  UploadingUploadingInitializer.swift
//  Photo Dump
//
//  Created by Vince Santos on 03/07/2020.
//  Copyright © 2020 Vince Santos. All rights reserved.
//

import UIKit

class UploadingModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var uploadingViewController: UploadingViewController!

    override func awakeFromNib() {

        let configurator = UploadingModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: uploadingViewController)
    }

}
