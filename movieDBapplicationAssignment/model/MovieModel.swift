//
//  MovieModel.swift
//  movieDBapplicationAssignment
//
//  Created by Aung Ko Ko on 03/10/2019.
//  Copyright © 2019 Phone Zaw Myint. All rights reserved.
//

import Foundation
import RealmSwift

class MovieModel {
    
    static let shared = MovieModel()
    
    private init() {}
    
    func fetchMoviesByName(movieName : String, completion : @escaping ([MovieInfoResponse]) -> Void) {
        let route = URL(string: "\(Routes.ROUTE_SEACRH_MOVIES)?api_key=\(API.KEY)&query=\(movieName.replacingOccurrences(of: " ", with: "%20") )")!
        URLSession.shared.dataTask(with: route) { (data, urlResponse, error) in
            let response : MovieListResponse? = self.responseHandler(data: data, urlResponse: urlResponse, error: error)
            if let data = response {
                completion(data.results)
            }
            }.resume()
    }
    
    func fetchMovieDetails(movieId : Int, completion: @escaping (MovieInfoResponse) -> Void) {
        let route = URL(string: "\(Routes.ROUTE_MOVIE_DETAILS)/\(movieId)?api_key=\(API.KEY)")!
        URLSession.shared.dataTask(with: route) { (data, urlResponse, error) in
            let response : MovieInfoResponse? = self.responseHandler(data: data, urlResponse: urlResponse, error: error)
            if let data = response {
                completion(data)
            }
            }.resume()
    }
    
    func fetchMovieVideo(movieId : Int, completion: @escaping ([VideoKeyResponse]) -> Void) {
        let route = URL(string: "\(Routes.ROUTE_MOVIE_DETAILS)/\(movieId)/videos?api_key=\(API.KEY)")!
        URLSession.shared.dataTask(with: route) { (data, urlResponse, error) in
            let response : VideoResponse? = self.responseHandler(data: data, urlResponse: urlResponse, error: error)
            if let data = response {
                completion(data.results)
            }else{
                completion([VideoKeyResponse]())
            }
            }.resume()
    }
    
    func fetchTopRatedMovies(pageId : Int = 1, completion : @escaping (([MovieInfoResponse]) -> Void) )  {
        let route = URL(string: "\(Routes.ROUTE_TOP_RATED_MOVIES)&page=\(pageId)")!
        URLSession.shared.dataTask(with: route) { (data, urlResponse, error) in
            let response : MovieListResponse? = self.responseHandler(data: data, urlResponse: urlResponse, error: error)
            if let data = response {
                //                print(data.results.count)
                completion(data.results)
                
            } else {
                completion([MovieInfoResponse]())
            }
            }.resume()
        
    }
    
    func fetchPopularMovies(pageId : Int = 1, completion : @escaping (([MovieInfoResponse]) -> Void) )  {
        let route = URL(string: "\(Routes.ROUTE_POPULAR_MOVIES)&page=\(pageId)")!
        URLSession.shared.dataTask(with: route) { (data, urlResponse, error) in
            let response : MovieListResponse? = self.responseHandler(data: data, urlResponse: urlResponse, error: error)
            if let data = response {
                //                print(data.results.count)
                completion(data.results)
                
            } else {
                completion([MovieInfoResponse]())
            }
            }.resume()
        
    }
    
    func fetchNowPlayingMovies(pageId : Int = 1, completion : @escaping (([MovieInfoResponse]) -> Void) )  {
        let route = URL(string: "\(Routes.ROUTE_NOWPLAYING_MOVIES)&page=\(pageId)")!
        URLSession.shared.dataTask(with: route) { (data, urlResponse, error) in
            let response : MovieListResponse? = self.responseHandler(data: data, urlResponse: urlResponse, error: error)
            if let data = response {
                //                print(data.results.count)
                completion(data.results)
                
            } else {
                completion([MovieInfoResponse]())
            }
            }.resume()
        
    }
    
    func fetchUpComingMovies(pageId : Int = 1, completion : @escaping (([MovieInfoResponse]) -> Void) )  {
        let route = URL(string: "\(Routes.ROUTE_UPCOMING_MOVIES)&page=\(pageId)")!
        URLSession.shared.dataTask(with: route) { (data, urlResponse, error) in
            let response : MovieListResponse? = self.responseHandler(data: data, urlResponse: urlResponse, error: error)
            if let data = response {
                //                print(data.results.count)
                completion(data.results)
                
            } else {
                completion([MovieInfoResponse]())
            }
            }.resume()
        
    }
    
    //
    func fetchSimilarMovies(pageId : Int = 1,movieId : Int, completion: @escaping ([MovieInfoResponse]) -> Void) {
        let route = URL(string: "\(Routes.ROUTE_MOVIE_DETAILS)/\(movieId)/similar?api_key=\(API.KEY)")!
         print("Route",route)
        URLSession.shared.dataTask(with: route) { (data, urlResponse, error) in
            let response : MovieListResponse? = self.responseHandler(data: data, urlResponse: urlResponse, error: error)
            if let data = response {
                completion(data.results)
                print(data.results.count)
            }else{
                completion([MovieInfoResponse]())
            }
            }.resume()
    }
    
    func fetchMovieGenres(completion : @escaping ([MovieGenreResponse]) -> Void ) {
        
        let route = URL(string: Routes.ROUTE_MOVIE_GENRES)!
        let task = URLSession.shared.dataTask(with: route) { (data, urlResponse, error) in
            let response : MovieGenreListResponse? = self.responseHandler(data: data, urlResponse: urlResponse, error: error)
            if let data = response {
                completion(data.genres)
            }
        }
        task.resume()
    }
    
    func fetchRequestToken(completion: @escaping(RequestTokenResponse)-> Void){
        let route = URL(string: Routes.ROUTE_CREATE_REQUEST_TOKEN)!
        let task = URLSession.shared.dataTask(with: route) { (data, urlResponse, error) in
            let response : RequestTokenResponse? = self.responseHandler(data: data, urlResponse: urlResponse, error: error)
            if let data = response {
                completion(data)
            }
        }
        task.resume()
    }
    
    func fetchRequestTokenWithAuthenticationLogin(request_Token: String,completion: @escaping(RequestTokenResponse)-> Void){
        let route = URL(string: Routes.ROUTE_CREATE_REQUEST_TOKEN_WITH_AUTH_LOGIN)!
        print("Route\(route)")
        var  request = URLRequest(url: route)
        request.httpMethod = "POST"
        let pram = ["username": "PhoneZawMyint",
                    "password": "12345678",
                    "request_token":request_Token]
        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: pram as NSObject, options: [])
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            let task = URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
                print("Data",data!)
                print("UrlResponse",urlResponse)
                do{
                    if let httpresponse = urlResponse as? HTTPURLResponse {
                        let statusCode = httpresponse.statusCode
                        if statusCode == 200 {
                            let decoder = JSONDecoder()
                            let session = try decoder.decode(RequestTokenResponse.self, from: data!)
                            completion(session)
                        }
                    }
                }catch let err{
                    print("Err",err.localizedDescription)
                }
            }
            task.resume()
        }catch let error{
            print("Failed",error.localizedDescription)
        }
    }
    
    
    
    func fetchRequestSessionId(request_Token: String,completion: @escaping(SessionIdResponse)-> Void){
        let route = URL(string: Routes.ROUTE_CREATE_SESSION_ID)!
        print("Route\(route)")
        var  request = URLRequest(url: route)
        request.httpMethod = "POST"
        let pram = ["request_token":request_Token]
        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: pram as NSObject, options: [])
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            let task = URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
                print("Data",data!)
                print("UrlResponse",urlResponse)
                do{
                    if let httpresponse = urlResponse as? HTTPURLResponse {
                        let statusCode = httpresponse.statusCode
                        if statusCode == 200 {
                            let decoder = JSONDecoder()
                            let session = try decoder.decode(SessionIdResponse.self, from: data!)
                            print("Session",session)
                            completion(session)
                        }
                    }
                }catch let err{
                    print("Err",err.localizedDescription)
                }
            }
            task.resume()
        }catch let error{
            print("Failed",error.localizedDescription)
        }
    }
    
    func fetchAccount(sessionId : String, completion: @escaping (AccountUser) -> Void) {
        let route = URL(string: "\(Routes.ROUTE_GET_ACCOUNT)?api_key=\(API.KEY)&session_id=\(sessionId)")!
        print("ROUTe",route)
        URLSession.shared.dataTask(with: route) { (data, urlResponse, error) in
            let response : AccountUser? = self.responseHandler(data: data, urlResponse: urlResponse, error: error)
            print("REsponse",response)
            if let data = response {
                completion(data)
            }
            }.resume()
    }
    
    func responseHandler<T : Decodable>(data : Data?, urlResponse : URLResponse?, error : Error?) -> T? {
        let TAG = String(describing: T.self)
        if error != nil {
            print("\(TAG): failed to fetch data : \(error!.localizedDescription)")
            return nil
        }
        
        let response = urlResponse as! HTTPURLResponse
        
        if response.statusCode == 200 {
            guard let data = data else {
                print("\(TAG): empty data")
                return nil
            }
            
            if let result = try? JSONDecoder().decode(T.self, from: data) {
                return result
            } else {
                print("\(TAG): failed to parse data")
                return nil
            }
        } else {
            print("\(TAG): Network Error - Code: \(response.statusCode)")
            return nil
        }
    }
    
}
