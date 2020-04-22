//
//  UnsplashImageView.swift
//  MapleLabs
//
//  Created by Nguyen Chau Chieu on 4/22/20.
//  Copyright © 2020 Nguyen Chau Chieu. All rights reserved.
//

import UIKit

class UnsplashImageView: UIImageView {
    
    override init(image: UIImage?) {
        super.init(image: image)

    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
    
}
