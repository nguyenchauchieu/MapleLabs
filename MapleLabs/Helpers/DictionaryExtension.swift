//
//  DictionaryExtension.swift
//  MapleLabs
//
//  Created by Nguyen Chau Chieu on 4/22/20.
//  Copyright © 2020 Nguyen Chau Chieu. All rights reserved.
//

import Foundation

extension Dictionary {
    mutating func update(other: Dictionary) {
        for (key, value) in other {
            self.updateValue(value, forKey: key)
        }
    }

    public func valueForKeyPath(keyPath: String) -> Any? {
        var keys = keyPath.components(separatedBy: ".")
        guard let first = keys.first as? Key else {
            return nil
        }

        guard let value = self[first] else {
            return nil
        }

        keys.remove(at: 0)

        if !keys.isEmpty, let subDict = value as? [NSObject : AnyObject] {
            let rejoined = keys.joined(separator: ".")
            return subDict.valueForKeyPath(keyPath: rejoined)
        }

        return value
    }
}
