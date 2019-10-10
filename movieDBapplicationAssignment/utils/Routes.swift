//
//  Routes.swift
//  movieDBapplicationAssignment
//
//  Created by Aung Ko Ko on 03/10/2019.
//  Copyright © 2019 Phone Zaw Myint. All rights reserved.
//

import Foundation
class Routes {
    static let ROUTE_MOVIE_GENRES = "\(API.BASE_URL)/genre/movie/list?api_key=\(API.KEY)"
    static let ROUTE_TOP_RATED_MOVIES = "\(API.BASE_URL)/movie/top_rated?api_key=\(API.KEY)"
    static let ROUTE_POPULAR_MOVIES = "\(API.BASE_URL)/movie/popular?api_key=\(API.KEY)"
    static let ROUTE_MOVIE_DETAILS = "\(API.BASE_URL)/movie"
    static let ROUTE_SEACRH_MOVIES = "\(API.BASE_URL)/search/movie"
    static let ROUTE_UPCOMING_MOVIES = "\(API.BASE_URL)/movie/upcoming?api_key=\(API.KEY)"
    static let ROUTE_NOWPLAYING_MOVIES = "\(API.BASE_URL)/movie/now_playing?api_key=\(API.KEY)"
    static let ROUTE_CREATE_REQUEST_TOKEN = "\(API.BASE_URL)/authentication/token/new?api_key=\(API.KEY)"
    static let ROUTE_CREATE_SESSION_ID = "\(API.BASE_URL)/authentication/session/new?api_key=\(API.KEY)"
    static let ROUTE_VALIDATE_WITH_LOGIN = "\(API.BASE_URL)/authentication/token/validate_with_login?api_key=\(API.KEY)"
    static let ROUTE_CREATE_REQUEST_TOKEN_WITH_AUTH_LOGIN = "\(API.BASE_URL)/authentication/token/validate_with_login?api_key=\(API.KEY)"
    static let ROUTE_GET_ACCOUNT = "\(API.BASE_URL)/movie/account"
   
}
