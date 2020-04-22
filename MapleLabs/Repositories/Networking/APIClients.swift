//
//  APIClients.swift
//  MapleLabs
//
//  Created by Nguyen Chau Chieu on 4/22/20.
//  Copyright © 2020 Nguyen Chau Chieu. All rights reserved.
//
import Alamofire
import Foundation

public typealias FailureRequest = (_ error: Error?, _ responseError:[String:Any]?) -> Void

class APIClient: NSObject {
    
    static let shared = APIClient()
    
    var baseURL: String = {
        return ConfigurationUtil.getConfigString(key: ConfigurationUtil.Unsplash.baseUrl.rawValue)
    }()
    
    fileprivate var reachabilityManager: NetworkReachabilityManager
    
    fileprivate lazy var manager: SessionManager = {
        let manager     = SessionManager()
        manager.adapter = AuthorizationAdapter()
        return manager
    }()
    
    override init() {
        reachabilityManager = NetworkReachabilityManager(host: baseURL)!
        super.init()
        reachabilityManager.listener = { status in
            switch status {
            case .reachable(.ethernetOrWiFi), .reachable(.wwan):
                NotificationCenter.default.post(name: Notifications.networkIsReachable.notification, object: .none)
            case .notReachable:
                NotificationCenter.default.post(name: Notifications.networkIsNotReachable.notification, object: .none)
            case .unknown:
                NotificationCenter.default.post(name: Notifications.networkIsNotReachable.notification, object: .none)
            }
        }
        reachabilityManager.startListening()
    }
    
    func get(_ path: String,
             parameters: [String: Any]?,
             success: ((Any?) -> Void)?,
             failure: @escaping FailureRequest) {
        self.execute(path,
                     isOAuth: false,
                     method: .get,
                     parameters: parameters,
                     headers: .none,
                     success: success,
                     failure: { (error, responseErrorMsg) in
                        failure(error, responseErrorMsg)
        })
    }
    
    fileprivate func execute(_ path: String, isOAuth: Bool, method: HTTPMethod, parameters: [String : Any]?, headers: [String : String]?, success: ((Any?) -> Void)?, failure: @escaping FailureRequest) {
        
//            var allowedCharacters = CharacterSet.urlQueryAllowed
//            allowedCharacters.insert(charactersIn: "%")
//            absolutePath = absolutePath.addingPercentEncoding(withAllowedCharacters: allowedCharacters)!
        
            guard let url = URL(string: baseURL + path) else {
                let info = [NSLocalizedDescriptionKey : "Cannot get url"]
                let error = NSError(domain: "Error", code: 0, userInfo: info)
                failure(error, info)
                return
            }
            
            let encoding: ParameterEncoding = method == .get ? URLEncoding.default : JSONEncoding.default
            
            let request = self.manager.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers)
            request.validate()
                .responseJSON { response in
                    debugPrint(">> REQUEST URL: \(path)")
                    debugPrint(">> METHOD: \(method)")
                    
                    switch response.result {
                    case .success:
                        success?(response.result.value)
                    case .failure(let error):
                        if let data = response.data {
                            do {
                                let errorDict = try JSONSerialization.jsonObject(with: data) as? [String: Any]
                                failure(error, errorDict)
                                return
                            } catch {
                                failure(error, nil)
                                return
                            }
                        }
                        
                        failure(error, nil)
                    }
            }
    }
}
