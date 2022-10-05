//
//  TmdbAPIService.swift
//  CI&T Movie Database
//
//  Created by Gilberto Junior on 19/08/22.
//

import Foundation

class TMDBAPIService {
    private static let apiBaseURL = "https://api.themoviedb.org/3/"
    private static let apiKey = "Insert you api key here"

    static func getCastAndCrewURLString(id: Int) -> URL? {
        let urlComponents = URLComponents(string: apiBaseURL + "movie/\(id)/credits?api_key=" + apiKey)
        
        return urlComponents?.url
    }
    
    static func getGenresURLString() -> URL? {
        let urlComponents = URLComponents(string: apiBaseURL + "genre/movie/list?api_key=" + apiKey)
        
        return urlComponents?.url
    }
    
    static func getNowPlayingURLString() -> URL? {
        let urlComponents = URLComponents(string: apiBaseURL + "movie/now_playing?api_key=" + apiKey)
        
        return urlComponents?.url
    }
    
    static func getUpcomingURLString() -> URL? {
        let urlComponents = URLComponents(string: apiBaseURL + "movie/upcoming?api_key=" + apiKey)
        
        return urlComponents?.url
    }
    
    static func getPhotosURLString(id: Int) -> URL? {
        let urlComponents = URLComponents(string: apiBaseURL + "movie/\(id)/images?api_key=" + apiKey)
        
        return urlComponents?.url
    }
    
    static func getMovieDetailsURLString(id: Int) -> URL? {
        let urlComponents = URLComponents(string: apiBaseURL + "movie/\(id)?api_key=" + apiKey)
        
        return urlComponents?.url
    }
}
