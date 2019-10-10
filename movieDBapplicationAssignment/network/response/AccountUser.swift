//
//  AccountUser.swift
//  movieDBapplicationAssignment
//
//  Created by Aung Ko Ko on 10/10/2019.
//  Copyright © 2019 Phone Zaw Myint. All rights reserved.
//

import Foundation
struct AccountUser : Codable {
    let id: Int?
    let iso_639_1: String?
    let iso_3166_1: String?
    let name: String?
    let include_adult: Bool?
    let username: String
}
