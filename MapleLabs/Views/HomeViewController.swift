//
//  ViewController.swift
//  MapleLabs
//
//  Created by Nguyen Chau Chieu on 4/22/20.
//  Copyright © 2020 Nguyen Chau Chieu. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var imageList = [UIImage]()
    var photoList = [Photo]()
    let photoRepository = PhotoRepository()
    var currentPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    func loadPhoto(withPage page: Int) {
        photoRepository.getPhotos(page: page, success: { (photos) in
            self.photoList.append(contentsOf: photos)
            self.currentPage = page
            self.collectionView.reloadData()
        }) { (error, errorMessage) in
            
        }
    }
    
    func setupCollectionView() {
        if let layout = collectionView?.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
        collectionView.dataSource = self
        collectionView.delegate = self
        loadPhoto(withPage: currentPage + 1)
    }
}

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCollectionViewCell", for: indexPath) as? HomeImageCollectionViewCell {
            cell.photo = photoList[indexPath.item]
            cell.setImage()
            return cell
        }
        return HomeImageCollectionViewCell()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoList.count
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == photoList.count - 1 {
            loadPhoto(withPage: currentPage + 1)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        let imageDetailVC = mainStoryboard.instantiateViewController(identifier: "imageDetailsViewController") as! ImageDetailsViewController
        imageDetailVC.photo = photoList[indexPath.row]
        let currentCell = collectionView.cellForItem(at: indexPath) as! HomeImageCollectionViewCell
        imageDetailVC.thumbnail = currentCell.imageView.image
        self.present(imageDetailVC, animated: true, completion: nil)
    }
}

extension HomeViewController: UICollectionViewDelegate {
}

extension HomeViewController: PinterestLayoutDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        heightForPhotoAtIndexPath indexPath: IndexPath, withColumnWidth: CGFloat) -> CGFloat {
        let imageRatio = (photoList[indexPath.item].height ?? 1) / (photoList[indexPath.item].width ?? 1)
        return withColumnWidth * imageRatio
    }
}

