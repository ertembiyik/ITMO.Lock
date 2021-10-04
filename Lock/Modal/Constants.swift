//
//  Constants.swift
//  Lock
//
//  Created by Ertem Biyik on 01.10.2021.
//

import UIKit

struct Constants {
    static let baseAPIUrl = "https://itmolock.herokuapp.com/v1/"
    static let accessToken = "accessToken"
    static let isAdmin = "isAdmin"
    static let themeBackGroundColor = UIColor(red: 0.04, green: 0.05, blue: 0.10, alpha: 1.0)
    static let accentColor = UIColor(red: 0.08, green: 0.09, blue: 0.15, alpha: 1.0)
    enum AccessAction {
        case add
        case remove
    }
        
}
