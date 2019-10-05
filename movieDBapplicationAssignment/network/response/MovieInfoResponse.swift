//
//  MovieInfoResponse.swift
//  movieDBapplicationAssignment
//
//  Created by Aung Ko Ko on 03/10/2019.
//  Copyright © 2019 Phone Zaw Myint. All rights reserved.
//

import Foundation
import RealmSwift

struct MovieInfoResponse : Codable {
    
    let popularity : Double?
    let vote_count : Int?
    let video : Bool?
    let poster_path : String?
    let id : Int?
    let adult : Bool?
    let backdrop_path : String?
    let original_language : String?
    let original_title : String?
    let genre_ids: [Int]?
    let title : String?
    let vote_average : Double?
    let overview : String?
    let release_date : String?
    let budget : Int?
    let homepage : String?
    let imdb_id : String?
    let revenue : Int?
    let runtime : Int?
    let tagline : String?
    
    //Production Companies
    //TODO: Parse Production Companies
    
    enum CodingKeys:String,CodingKey {
        case popularity
        case vote_count
        case video
        case poster_path
        case id
        case adult
        case backdrop_path
        case original_language
        case original_title
        case genre_ids
        case title
        case vote_average
        case overview
        case release_date
        case budget
        case homepage
        case imdb_id
        case revenue
        case runtime
        case tagline = "tagline"
    }
    
    static func saveMovie(data : MovieInfoResponse, realm : Realm, category: String) {
        //TODO: Implement Realm Save Movie Logic
        let movieData = realm.object(ofType: MovieVO.self, forPrimaryKey: data.id)
        if movieData == nil {
            let movie = MovieVO()
            movie.popularity = data.popularity!
            movie.vote_count = data.vote_count ?? 0
            movie.video = data.video!
            movie.poster_path = data.poster_path ?? ""
            movie.id = data.id!
            movie.adult = data.adult!
            movie.backdrop_path = data.backdrop_path ?? ""
            movie.original_title = data.original_title
            movie.original_language = data.original_language ?? ""
            movie.title = data.title!
            movie.vote_average = data.vote_average!
            movie.overview = data.overview!
            movie.release_date = data.release_date!
            movie.budget = data.budget ?? 0
            movie.homepage = data.homepage
            movie.imdb_id = data.imdb_id
            movie.revenue = data.revenue ?? 0
            movie.runtime = data.runtime ?? 0
            movie.tagline = data.tagline
            movie.category = category
            if let genre_ids = data.genre_ids, !genre_ids.isEmpty {
                genre_ids.forEach{ id in
                    if let movieGenreVO = MovieGenreVO.getMovieGenreVOById(realm: realm, genreId: id) {
                        
                        movie.genres.append(movieGenreVO)
                    }
                }
            }
            
            do{
                try realm.write {
                    realm.add(movie)
                }
            }catch{
                print("Fail save Movie Response")
            }
        }
    }
    
    static func convertToMovieVO(data : MovieInfoResponse, realm : Realm) -> MovieVO {
        let movie = MovieVO()
        movie.popularity = data.popularity!
        movie.vote_count = data.vote_count ?? 0
        movie.video = data.video!
        movie.poster_path = data.poster_path ?? ""
        movie.id = data.id!
        movie.adult = data.adult!
        movie.backdrop_path = data.backdrop_path ?? ""
        movie.original_title = data.original_title
        movie.original_language = data.original_language ?? ""
        movie.title = data.title!
        movie.vote_average = data.vote_average!
        movie.overview = data.overview!
        movie.release_date = data.release_date!
        movie.budget = data.budget ?? 0
        movie.homepage = data.homepage
        movie.imdb_id = data.imdb_id
        movie.revenue = data.revenue ?? 0
        movie.runtime = data.runtime ?? 0
        movie.tagline = data.tagline
        
        return movie
    }
    
}
