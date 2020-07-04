//
//  ImagePreviewImagePreviewViewController.swift
//  Photo Dump
//
//  Created by Vince Santos on 03/07/2020.
//  Copyright © 2020 Vince Santos. All rights reserved.
//

import UIKit

class ImagePreviewViewController: UIViewController, ImagePreviewViewInput {
    var output: ImagePreviewViewOutput!
    var image: ImagesData?
    var caption = ""
    
    @IBOutlet weak var captionTextView: UITextView!
    @IBOutlet weak var imageContainer: UIImageView!
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
        setupInitialState()
    }


    // MARK: ImagePreviewViewInput
    func setupInitialState() {
        imageContainer.image = image?.image
        captionTextView.text = caption
        captionTextView.layer.cornerRadius = 20
        captionTextView.clipsToBounds = true
        imageContainer.addTapGestureRecognizer {
            self.captionTextView.isHidden.toggle()
        }
    }
    
    func deletedData() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func closeBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func deleteBtn(_ sender: Any) {
        output.deleteData(imageData: image!)
    }
}
