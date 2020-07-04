//
//  MainMainInitializer.swift
//  Photo Dump
//
//  Created by Vince Santos on 02/07/2020.
//  Copyright © 2020 Vince Santos. All rights reserved.
//

import UIKit

class MainModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var mainViewController: MainViewController!

    override func awakeFromNib() {

        let configurator = MainModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: mainViewController)
    }

}
