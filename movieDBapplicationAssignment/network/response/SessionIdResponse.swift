//
//  SessionIdResponse.swift
//  movieDBapplicationAssignment
//
//  Created by Aung Ko Ko on 04/10/2019.
//  Copyright © 2019 Phone Zaw Myint. All rights reserved.
//

import Foundation
import RealmSwift

struct SessionIdResponse: Codable {
    let success: Bool?
    let session_id: String?
}
