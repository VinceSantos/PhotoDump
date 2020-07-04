//
//  AttachmentHandlerViewController.swift
//  Photo Dump
//
//  Created by Vince Carlo Santos on 02/07/2020.
//  Copyright © 2020 Vince Carlo Santos. All rights reserved.
//

import UIKit
import Photos

struct ImagesDataModel {
    var image: UIImage?
    var isSelected: Bool?
}

class AttachmentHandlerViewController: UIViewController {
    var allPhotos = [ImagesDataModel]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Photo Library"
        fetchAllPhotos()
        setupCollectionViewSettings()
    }
    
    override func viewDidLayoutSubviews() {
        let layout  = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.height / 5)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView.collectionViewLayout = layout
    }
    
    func fetchAllPhotos() {
        let imageManager = PHImageManager.default()
        
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true
        requestOptions.deliveryMode = .highQualityFormat
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        let fetchResult: PHFetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        
        if fetchResult.count > 0 {
            for i in 0..<fetchResult.count {
                imageManager.requestImage(for: fetchResult.object(at: i), targetSize: CGSize(width: 150, height: 150), contentMode: .aspectFill, options: requestOptions, resultHandler:
                    {
                        image, error in
                        
                        self.allPhotos.append(ImagesDataModel(image: image!, isSelected: false))
                })
            }
        } else {
            print("No Photos")
        }
    }
    
    func showPhotoLibrary(vc: UIViewController) {
        vc.present(self, animated: true, completion: nil)
    }
    
    @IBAction func submitBtnClick(_ sender: Any) {
        let test = allPhotos.filter { $0.isSelected == true}
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: String(describing: UploadingViewController.self)) as! UploadingViewController
        vc.listPhotos = test
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension AttachmentHandlerViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func setupCollectionViewSettings() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PhotoLibraryCollectionCell.self, forCellWithReuseIdentifier: "attachmentView")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "attachmentView", for: indexPath as IndexPath) as! PhotoLibraryCollectionCell
        cell.eventImage.image = allPhotos[indexPath.row].image
        if allPhotos[indexPath.row].isSelected! {
            cell.eventImage.layer.borderColor = UIColor.red.cgColor
            cell.eventImage.layer.borderWidth = 2
        } else {
            cell.eventImage.layer.borderColor = UIColor.white.cgColor
            cell.eventImage.layer.borderWidth = 1
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        allPhotos[indexPath.row].isSelected?.toggle()
        collectionView.reloadData()
    }
}

class PhotoLibraryCollectionCell: UICollectionViewCell {
    let eventImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.gray.cgColor
        imageView.layer.borderWidth = 1
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    func setUpView() {
        addSubview(eventImage)
        eventImage.anchorGlobalSet(topAnchor: self.topAnchor, tConst: 0, leftAnchor: self.leftAnchor, lConst: 0, rightAnchor: self.rightAnchor, rConst: 0, bottomAnchor: self.bottomAnchor, bConst: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
