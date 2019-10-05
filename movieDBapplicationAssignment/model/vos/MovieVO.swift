//
//  MovieVO.swift
//  movieDBapplicationAssignment
//
//  Created by Aung Ko Ko on 03/10/2019.
//  Copyright © 2019 Phone Zaw Myint. All rights reserved.
//

import Foundation
import RealmSwift

class MovieVO : Object {
    
    @objc dynamic var popularity : Double = 0
    @objc dynamic var vote_count : Int = 0
    @objc dynamic var video : Bool = false
    @objc dynamic var poster_path : String?
    @objc dynamic var id : Int = 0
    @objc dynamic var adult : Bool = false
    @objc dynamic var backdrop_path : String?
    @objc dynamic var original_language : String?
    @objc dynamic var original_title : String?
    @objc dynamic var title : String?
    @objc dynamic var vote_average : Double = 0
    @objc dynamic var overview : String?
    @objc dynamic var release_date : String?
    @objc dynamic var budget : Int = 0
    @objc dynamic var homepage : String?
    @objc dynamic var imdb_id : String?
    @objc dynamic var revenue : Int = 0
    @objc dynamic var runtime : Int = 0
    @objc dynamic var tagline : String?
    var genres = List<MovieGenreVO>()
    @objc dynamic var category: String?
    
    override class func primaryKey() -> String? {
        return "id"
    }
}


extension MovieVO {
    static func getMovieById(movieId : Int, realm : Realm) -> MovieVO? {
        let movie = realm.object(ofType: MovieVO.self, forPrimaryKey: movieId)
        return movie
    }
}
