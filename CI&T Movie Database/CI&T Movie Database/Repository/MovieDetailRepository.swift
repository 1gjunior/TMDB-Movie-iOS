//
//  MovieDetailRepository.swift
//  CI&T Movie Database
//
//  Created by Gilberto Junior on 10/08/22.
//

import Foundation

/// @mockable
protocol MovieDetailRepositoryProtocol {
    func getMovieDetailsBy(movieId: Int, completion: @escaping (Result<MovieDetail, Error>) -> Void)
}

class MovieDetailRepository: MovieDetailRepositoryProtocol {
    private let apiManager: APIManagerService

    init(apiManager: APIManagerService = APIManager()) {
        self.apiManager = apiManager
    }

    func getMovieDetailsBy(movieId: Int, completion: @escaping (Result<MovieDetail, Error>) -> Void) {
        guard let url = TMDBAPIService.getMovieDetailsURLString(id: movieId) else { return }

        apiManager.fetchItems(url: url) { (result: Result<MovieDetail, Error>) in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
