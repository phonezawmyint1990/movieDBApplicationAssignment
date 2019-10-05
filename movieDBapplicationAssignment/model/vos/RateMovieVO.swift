//
//  RateMovieVO.swift
//  movieDBapplicationAssignment
//
//  Created by Aung Ko Ko on 05/10/2019.
//  Copyright © 2019 Phone Zaw Myint. All rights reserved.
//

import Foundation
import RealmSwift

class RateMovieVO : Object {
    @objc dynamic var id : String = UUID().uuidString
    @objc dynamic var movie_id : Int = 0
    @objc dynamic var movieDetails : MovieVO?
    
    override class func primaryKey() -> String? {
        return "movie_id"
    }
}


extension RateMovieVO {
    static func saveMovieBookmark(movieId : Int, realm : Realm) {
        let ratmov = RateMovieVO()
        ratmov.movie_id = movieId
        ratmov.movieDetails = realm.object(ofType: MovieVO.self, forPrimaryKey: movieId)
        do{
            try realm.write {
                realm.add(ratmov)
            }
        }catch{
            print("Failed Save ratmov Movie")
        }
    }
}
