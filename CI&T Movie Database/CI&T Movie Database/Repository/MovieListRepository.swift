//
//  MovieListRepository.swift
//  CI&T Movie Database
//
//  Created by Gilberto Junior on 10/08/22.
//

import Foundation

protocol MovieListRepositoryProtocol {
    func getNowPlayingMovies(completion: @escaping (Result<[Movie], Error>) -> Void)
    func getUpcomingMovies(completion: @escaping (Result<[Movie], Error>) -> Void)
}

class MovieListRepository: MovieListRepositoryProtocol {
    private let apiManager: APIManagerService

    init(apiManager: APIManagerService = APIManager()) {
        self.apiManager = apiManager
    }

    func getNowPlayingMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a5a29cab08554d8a0b331b250a19170b")!
        
        apiManager.fetchItems(url: url) { (result: Result<MoviesResponse, Error>) in
            switch result {
            case .success(let data):
                completion(.success(data.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getUpcomingMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        let url = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=a5a29cab08554d8a0b331b250a19170b")!
        
        apiManager.fetchItems(url: url) { (result: Result<MoviesResponse, Error>) in
            switch result {
            case .success(let data):
                completion(.success(data.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
