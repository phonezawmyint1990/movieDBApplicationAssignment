//
//  VideoResponse.swift
//  movieDBapplicationAssignment
//
//  Created by Aung Ko Ko on 05/10/2019.
//  Copyright © 2019 Phone Zaw Myint. All rights reserved.
//

import Foundation
import RealmSwift

struct VideoResponse : Codable {
    let id: Int?
    let results: [VideoKeyResponse]
}

