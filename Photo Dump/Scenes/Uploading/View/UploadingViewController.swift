//
//  UploadingUploadingViewController.swift
//  Photo Dump
//
//  Created by Vince Santos on 03/07/2020.
//  Copyright © 2020 Vince Santos. All rights reserved.
//

import UIKit

class UploadingViewController: UITableViewController, UploadingViewInput {
    var output: UploadingViewOutput!
    var listPhotos = [ImagesDataModel]()
    var captionsData = [String]()
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
        navigationSetup()
        tableViewSetup()
        setupInitialState()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listPhotos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ImagesListTableViewCell.self)) as! ImagesListTableViewCell
        cell.listImage.image = listPhotos[indexPath.row].image
        cell.listTextField.delegate = self
        cell.listTextField.tag = indexPath.row
        return cell
    }

    // MARK: UploadingViewInput
    func uploadDone() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    // MARK: Setup
    func setupInitialState() {
        for _ in listPhotos {
            captionsData.append("")
        }
    }
    
    func navigationSetup() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Upload", style: .plain, target: self, action: #selector(uploadImages))
    }
    
    func tableViewSetup() {
        tableView.register(UINib(nibName: String(describing: ImagesListTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: ImagesListTableViewCell.self))
    }
    
    // MARK: Actions
    @objc func uploadImages() {
        output.uploadData(imageData: listPhotos, captionData: captionsData)
    }
}

extension UploadingViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        captionsData[textField.tag] = textField.text ?? ""
    }
}
