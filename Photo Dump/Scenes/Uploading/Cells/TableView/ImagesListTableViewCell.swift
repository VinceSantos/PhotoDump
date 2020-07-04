//
//  ImagesListTableViewCell.swift
//  Photo Dump
//
//  Created by Vince Carlo Santos on 03/07/2020.
//  Copyright © 2020 Vince Carlo Santos. All rights reserved.
//

import UIKit

class ImagesListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var listTextField: UITextField!
    @IBOutlet weak var listImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
