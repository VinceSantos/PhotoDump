//
//  ActivityIndicator.swift
//  Photo Dump
//
//  Created by Vince Carlo Santos on 03/07/2020.
//  Copyright © 2020 Vince Carlo Santos. All rights reserved.
//

import UIKit


class ActivityIndicator: UIViewController {
    
    let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
    let shadowImage = UIImageView()

    func show(uiView: UIViewController) {
        
        shadowImage.frame = CGRect(x: 0, y: 0, width: uiView.view.frame.size.width, height: uiView.view.frame.size.height)
        shadowImage.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        activityIndicator.center = view.center
        
        uiView.view.addSubview(shadowImage)
        uiView.view.addSubview(activityIndicator)
        self.shadowImage.isHidden = false
        
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    func stop(uiView: UIViewController) {
        
        UIView.animate(withDuration: 0.3) {
            self.activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            self.shadowImage.isHidden = true
        }
    }
    
}
