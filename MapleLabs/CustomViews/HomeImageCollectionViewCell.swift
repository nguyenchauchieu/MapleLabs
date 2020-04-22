//
//  HomeImageCollectionViewCell.swift
//  MapleLabs
//
//  Created by Nguyen Chau Chieu on 4/22/20.
//  Copyright © 2020 Nguyen Chau Chieu. All rights reserved.
//

import UIKit

class HomeImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UnsplashImageView!
    var photo: Photo?
    
    func setImage() {
        guard let photo = photo, let thumbnailLink = photo.thumnailLink, let thumbnailUrl = URL(string: thumbnailLink) else {
            return
        }
        imageView.loadImage(url: thumbnailUrl)
    }
}
