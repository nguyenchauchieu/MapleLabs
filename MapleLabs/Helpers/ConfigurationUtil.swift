//
//  ConfigurationUtil.swift
//  MapleLabs
//
//  Created by Nguyen Chau Chieu on 4/22/20.
//  Copyright © 2020 Nguyen Chau Chieu. All rights reserved.
//
import UIKit
class ConfigurationUtil {
    
    // MARK: - Public configurable enum types
    
    enum Unsplash: String {
        case baseUrl = "Unsplash.baseUrl"
        case accessKey = "Unsplash.accessKey"
    }
    
    static private func getConfigDictionary() -> [String: Any] {
        struct Holder {
            static var configDictionary: [String: Any]?
        }
        
        if Holder.configDictionary == nil {
            // read config file
            if let configPath = Bundle(for: self).path(forResource: "Configuration", ofType: "plist") {
                if let dic = NSDictionary(contentsOfFile: configPath) as? [String: Any] {
                    Holder.configDictionary = dic
                }
            }
        }
        
        if let dict = Holder.configDictionary {
            return dict
        }
        return [String: Any]()
    }
    
    static func getConfigString(key: String) -> String {

        if let value = getConfigDictionary().valueForKeyPath(keyPath: key) {
            return value as! String
        }
        return ""
    }
    
    static func getConfigBool(key: String) -> Bool {
        
        if let value = getConfigDictionary().valueForKeyPath(keyPath: key) {
            return value as! Bool
        }
        return false
    }
    
}
