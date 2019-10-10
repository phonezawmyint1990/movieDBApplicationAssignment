//
//  VideoKeyResponse.swift
//  movieDBapplicationAssignment
//
//  Created by Aung Ko Ko on 05/10/2019.
//  Copyright © 2019 Phone Zaw Myint. All rights reserved.
//

import Foundation
import RealmSwift
struct VideoKeyResponse : Codable {
    let id : String?
    let iso_639_1 : String?
    let iso_3166_1 : String?
    let key: String?
    let name : String?
    let site : String?
    let size : Int?
    let type : String?
}
