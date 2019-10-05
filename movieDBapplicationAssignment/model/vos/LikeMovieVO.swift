//
//  LikeMovieVO.swift
//  movieDBapplicationAssignment
//
//  Created by Aung Ko Ko on 05/10/2019.
//  Copyright © 2019 Phone Zaw Myint. All rights reserved.
//

import Foundation
import RealmSwift

class LikeMovieVO : Object {
    @objc dynamic var id : String = UUID().uuidString
    @objc dynamic var movie_id : Int = 0
    @objc dynamic var movieDetails : MovieVO?
    
    override class func primaryKey() -> String? {
        return "movie_id"
    }
}


extension LikeMovieVO {
    static func saveMovieBookmark(movieId : Int, realm : Realm) {
        let livmov = LikeMovieVO()
        livmov.movie_id = movieId
        livmov.movieDetails = realm.object(ofType: MovieVO.self, forPrimaryKey: movieId)
        do{
            try realm.write {
                realm.add(livmov)
            }
        }catch{
            print("Failed Save livmov Movie")
        }
    }
}
