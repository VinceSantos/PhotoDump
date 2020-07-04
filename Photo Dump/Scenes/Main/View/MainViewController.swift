//
//  MainMainViewController.swift
//  Photo Dump
//
//  Created by Vince Santos on 02/07/2020.
//  Copyright © 2020 Vince Santos. All rights reserved.
//

import UIKit
import Photos

class MainViewController: UIViewController, MainViewInput {

    var output: MainViewOutput!
    var localPhotos = [ImagesData]()
    let imagePickerController = UIImagePickerController()
    var filteredPhotos = [String : [ImagesData]]()
    var filterKeys = [String]()
    var isFiltered = false
    
    @IBOutlet weak var uploadBtn: UIButtonDesignable!
    @IBOutlet weak var bottomHud: UIViewDesignable!
    @IBOutlet weak var collectionView: UICollectionView!
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
        setupCollectionViewSettings()
        navigationSetup()
        setupInitialState()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if isFiltered {
            filterByDay()
        } else {
            output.loadLocalData()
        }
    }

    override func viewDidLayoutSubviews() {
        let layout  = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.height / 5)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.headerReferenceSize = CGSize(width: self.view.frame.width, height: 32)
        collectionView.collectionViewLayout = layout
        bottomHud.roundCorners(corners: [.topLeft, .topRight], radius: 15)
    }
    
    // MARK: MainViewInput
    func getLocalData(data: [ImagesData]) {
        localPhotos = data
        collectionView.reloadData()
    }
    
    @objc func filterByDay() {
        output.loadLocalData()
        if !localPhotos.isEmpty {
            filteredPhotos = Dictionary(grouping: localPhotos, by: {$0.dateString})
            filterKeys = Array(filteredPhotos.keys)
            isFiltered = true
            collectionView.reloadData()
        }
    }
    
    @objc func photoLibraryAction() {
        let actionSheet = UIAlertController(title: "Image Source", message: "Choose a Source", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action) in
            self.imagePickerController.sourceType = .camera
            self.present(self.imagePickerController, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action) in
            self.output.showImageLibrary()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    //MARK: MainViewSetup
    func navigationSetup() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterByDay))
    }
    
    func setupInitialState() {
        imagePickerController.delegate = self
        uploadBtn.addTarget(self, action: #selector(photoLibraryAction), for: .touchUpInside)
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func setupCollectionViewSettings() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PhotoLibraryCollectionCell.self, forCellWithReuseIdentifier: "attachmentView")
        collectionView.register(UINib(nibName: "HeaderCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderCollectionReusableView")
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if isFiltered {
            return filterKeys.count
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFiltered {
            return filteredPhotos[filterKeys[section]]?.count ?? 0
        } else {
            return localPhotos.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "attachmentView", for: indexPath as IndexPath) as! PhotoLibraryCollectionCell
        if isFiltered {
            cell.eventImage.image = filteredPhotos[filterKeys[indexPath.section]]![indexPath.row].image
        } else {
            cell.eventImage.image = localPhotos[indexPath.row].image
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderCollectionReusableView", for: indexPath) as! HeaderCollectionReusableView
        if isFiltered {
            let dateString = filteredPhotos[filterKeys[indexPath.section]]!.first?.dateString
            let dateFormatterInput = DateFormatter()
            dateFormatterInput.dateFormat = "MM.dd.yyyy"
            let rawDate = dateFormatterInput.date(from: dateString!)
            dateFormatterInput.dateFormat = "EEEE, MMM d, yyyy"
            let finalDate = dateFormatterInput.string(from: rawDate!)
            headerView.dateLabel.text = finalDate
        } else {
            if localPhotos.isEmpty {
                headerView.dateLabel.text = "Your Images seems to be empty."
            } else {
                headerView.dateLabel.text = "All Images"
            }
        }
        
        return headerView
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: String(describing: ImagePreviewViewController.self)) as! ImagePreviewViewController
        if isFiltered {
            vc.image = filteredPhotos[filterKeys[indexPath.section]]![indexPath.row]
            vc.caption = filteredPhotos[filterKeys[indexPath.section]]![indexPath.row].caption
        } else {
            vc.image = localPhotos[indexPath.row]
            vc.caption = localPhotos[indexPath.row].caption
        }
        present(vc, animated: true, completion: nil)
    }
}

extension MainViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        let imageModel = ImagesDataModel(image: image, isSelected: true)
        imagePickerController.dismiss(animated: true) {
            self.output.showImage(image: imageModel)
        }
    }
}
