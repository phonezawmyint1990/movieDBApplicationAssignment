//
//  MovieGenreListResponse.swift
//  movieDBapplicationAssignment
//
//  Created by Aung Ko Ko on 03/10/2019.
//  Copyright © 2019 Phone Zaw Myint. All rights reserved.
//

import Foundation
import RealmSwift

struct MovieGenreListResponse: Codable {
    let genres : [MovieGenreResponse]
}
