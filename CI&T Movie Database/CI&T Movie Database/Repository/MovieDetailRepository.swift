//
//  MovieDetailRepository.swift
//  CI&T Movie Database
//
//  Created by Gilberto Junior on 10/08/22.
//

import Foundation

protocol MovieDetailRepositoryProtocol {
    func getMovieDetailsBy(movieId: Int, completion: @escaping (Result<MovieDetail, Error>) -> Void)
}

class MovieDetailRepository: MovieDetailRepositoryProtocol {
    private let apiManager: APIManagerService

    init(apiManager: APIManagerService = APIManager()) {
        self.apiManager = apiManager
    }

    func getMovieDetailsBy(movieId: Int, completion: @escaping (Result<MovieDetail, Error>) -> Void) {
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)?api_key=a5a29cab08554d8a0b331b250a19170b")!

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
