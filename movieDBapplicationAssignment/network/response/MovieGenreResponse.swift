//
//  MovieGenreResponse.swift
//  movieDBapplicationAssignment
//
//  Created by Aung Ko Ko on 03/10/2019.
//  Copyright © 2019 Phone Zaw Myint. All rights reserved.
//

import Foundation
import CoreData
import RealmSwift

struct MovieGenreResponse : Codable {
    let id : Int
    let name : String
    
    static func saveMovieGenre(data : MovieGenreResponse, realm: Realm) {
        
        let genericMovie = MovieGenreVO()
        genericMovie.id = data.id
        genericMovie.name = data.name
        do{
            try realm.write {
                realm.add(genericMovie)
            }
        }catch{
            print("Failed Genenic Movie")
        }
    }
}
