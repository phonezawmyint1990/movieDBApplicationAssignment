//
//  MovieGenreVO.swift
//  movieDBapplicationAssignment
//
//  Created by Aung Ko Ko on 03/10/2019.
//  Copyright © 2019 Phone Zaw Myint. All rights reserved.
//

import Foundation
import RealmSwift

class MovieGenreVO : Object {
    @objc dynamic var id : Int = 0
    @objc dynamic var name : String = ""
    let movies = LinkingObjects(fromType: MovieVO.self, property: "genres")
    
    override class func primaryKey() -> String? {
        return "id"
    }
}


extension MovieGenreVO {
    static func getMovieGenreVOById(realm : Realm, genreId : Int) -> MovieGenreVO? {
        let movie = realm.object(ofType: MovieGenreVO.self, forPrimaryKey: genreId)
        return movie
    }
}
