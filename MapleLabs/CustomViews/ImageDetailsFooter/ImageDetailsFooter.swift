//
//  ImageDetailsFooter.swift
//  MapleLabs
//
//  Created by Nguyen Chau Chieu on 4/23/20.
//  Copyright © 2020 Nguyen Chau Chieu. All rights reserved.
//

import UIKit

protocol ImageDetailsFooterDelegate: class {
    func didTapDownloadButton()
}

class ImageDetailsFooter: UIView {
    
    weak var delegate: ImageDetailsFooterDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initView()
    }
    
    func initView() {
        let view = Bundle.main.loadNibNamed("ImageDetailsFooter", owner: self, options: nil)?.first as! UIView
        view.frame = CGRect.init(x: 0, y: 0, width: bounds.width, height: bounds.height)
        self.addSubview(view)
    }
    @IBAction func downloadButtonTouchUpInside(_ sender: Any) {
        delegate?.didTapDownloadButton()
    }
    
}
