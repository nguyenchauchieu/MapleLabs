//
//  ImageDetailsViewController.swift
//  MapleLabs
//
//  Created by Nguyen Chau Chieu on 4/23/20.
//  Copyright © 2020 Nguyen Chau Chieu. All rights reserved.
//

import UIKit

class ImageDetailsViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var imageDetailsFooter: ImageDetailsFooter!
    var thumbnail: UIImage?
    
    var photo: Photo?
    let photoRepository = PhotoRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFooter()
        loadImage()
    }
    
    @IBAction func closeButtonTouchUpInside(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func loadImage() {
        
        if let photo = photo, let thumbnail = thumbnail, let photoLink = photo.photoLink, let photoUrl = URL(string: photoLink) {
            imageView.image = thumbnail
            imageView.loadImage(url: photoUrl)
        }
    }
    
    func setupFooter() {
        imageDetailsFooter.delegate = self
    }

}

extension ImageDetailsViewController: ImageDetailsFooterDelegate {
    func didTapDownloadButton() {
        if let photo = photo, let photoRawLink = photo.rawPhotoLink, let photoRawUrl = URL(string: photoRawLink) {
            photoRepository.saveImageToDisk(from: photoRawUrl, success: nil)
        }
    }
}
