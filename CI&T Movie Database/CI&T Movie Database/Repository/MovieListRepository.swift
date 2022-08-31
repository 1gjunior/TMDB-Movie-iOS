//
//  MovieListRepository.swift
//  CI&T Movie Database
//
//  Created by Gilberto Junior on 10/08/22.
//

import Foundation

/// @mockable
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
        guard let url = TMDBAPIService.getNowPlayingURLString() else { return }

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
        guard let url = TMDBAPIService.getUpcomingURLString() else { return }

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
