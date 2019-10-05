//
//  User.swift
//  movieDBapplicationAssignment
//
//  Created by Aung Ko Ko on 04/10/2019.
//  Copyright © 2019 Phone Zaw Myint. All rights reserved.
//

import Foundation
import RealmSwift
struct User: Codable {
    let username: String?
    let password: String?
    let request_token: String?
    
    enum CodingKeys:String,CodingKey {
        case username
        case password
        case request_token
    }
}
