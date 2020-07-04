//
//  ImagePreviewImagePreviewInitializer.swift
//  Photo Dump
//
//  Created by Vince Santos on 03/07/2020.
//  Copyright © 2020 Vince Santos. All rights reserved.
//

import UIKit

class ImagePreviewModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var imagepreviewViewController: ImagePreviewViewController!

    override func awakeFromNib() {

        let configurator = ImagePreviewModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: imagepreviewViewController)
    }

}
