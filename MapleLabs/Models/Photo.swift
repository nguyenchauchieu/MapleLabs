//
//  Photo.swift
//  MapleLabs
//
//  Created by Nguyen Chau Chieu on 4/22/20.
//  Copyright © 2020 Nguyen Chau Chieu. All rights reserved.
//

import Foundation
import UIKit

enum PhotoKey: String, CodingKey {
    case id
    case width
    case height
    case urls
}

enum UrlLinks: String, CodingKey {
    case thumb
    case small
    case regular
    case raw
}

struct Photo {
    var id: String?
    var thumnailLink: String?
    var photoLink: String?
    var rawPhotoLink: String?
    var width: CGFloat?
    var height: CGFloat?
}

extension Photo: Decodable {
    init(from decoder: Decoder) throws {
        let photoContainer = try decoder.container(keyedBy: PhotoKey.self)
        let urlLinksContainer = try photoContainer.nestedContainer(keyedBy: UrlLinks.self, forKey: PhotoKey.urls)
        
        id = try photoContainer.decode(String.self, forKey: .id)
        width = try photoContainer.decode(CGFloat.self, forKey: .width)
        height = try photoContainer.decode(CGFloat.self, forKey: .height)
        thumnailLink = try urlLinksContainer.decode(String.self, forKey: .thumb)
        photoLink = try urlLinksContainer.decode(String.self, forKey: .regular)
        rawPhotoLink = try urlLinksContainer.decode(String.self, forKey: .raw)
    }
}
