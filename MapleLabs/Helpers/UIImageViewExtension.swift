//
//  UIImageViewExtension.swift
//  MapleLabs
//
//  Created by Nguyen Chau Chieu on 4/22/20.
//  Copyright © 2020 Nguyen Chau Chieu. All rights reserved.
//
import UIKit

extension UIImageView {
    func loadImage(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
