//
//  AuthorizationAdapter.swift
//  MapleLabs
//
//  Created by Nguyen Chau Chieu on 4/22/20.
//  Copyright © 2020 Nguyen Chau Chieu. All rights reserved.
//

import Foundation
import Alamofire
class AuthorizationAdapter: RequestAdapter {
    
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        urlRequest.setValue("Client-ID " + ConfigurationUtil.getConfigString(key: ConfigurationUtil.Unsplash.accessKey.rawValue), forHTTPHeaderField: "Authorization")
        urlRequest.setValue("v1", forHTTPHeaderField: "Accept-Version")
        return urlRequest
    }
}
