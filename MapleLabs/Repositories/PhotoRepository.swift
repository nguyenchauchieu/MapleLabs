//
//  PhotoRepository.swift
//  MapleLabs
//
//  Created by Nguyen Chau Chieu on 4/22/20.
//  Copyright © 2020 Nguyen Chau Chieu. All rights reserved.
//

import Foundation
import UIKit

class PhotoRepository: NSObject {
    func getPhotos(page: Int, success: @escaping (([Photo]) -> Void), failure: FailureRequest) {
        APIClient.shared.get("/photos?page=\(page)", parameters: .none, success: { results in
            let decoder = JSONDecoder()
            if let results = results, let data = try? JSONSerialization.data(withJSONObject: results) {
                if let photos = try? decoder.decode([Photo].self, from: data) {
                    success(photos)
                }
            }
        }) { (error, errorMessage) in
            
        }
    }
    
    func saveImageToDisk(from url: URL, success: (() -> ())?) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                }
            }
        }
    }
}
