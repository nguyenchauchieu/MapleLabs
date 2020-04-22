//
//  Constants.swift
//  MapleLabs
//
//  Created by Nguyen Chau Chieu on 4/22/20.
//  Copyright © 2020 Nguyen Chau Chieu. All rights reserved.
//

import Foundation

enum Notifications: String {
    case networkIsReachable    = "NotificationIsReachable"
    case networkIsNotReachable = "NotificationIsNotReachable"

    case newWatchlist     = "NotificationNewWatchlist"
    case deletedWatchlist = "NotificationDeletedWatchlist"
    case newInvite        = "NotificationNewInvite"
    case newEvent         = "NotificationNewEvent"
    case newMatched       = "NotificationNewMatched"
    case openGroupChat    = "NotificationOpenGroupChat"
    
    var notification: NSNotification.Name {
        return NSNotification.Name(rawValue: self.rawValue)
    }
}
