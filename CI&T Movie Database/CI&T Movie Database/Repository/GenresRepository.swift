//
//  GenresRepository.swift
//  CI&T Movie Database
//
//  Created by Gilberto Junior on 10/08/22.
//

import Foundation

protocol GenresRepositoryProtocol {
    func getGenres(completion: @escaping (Result<[MovieGenre], Error>) -> Void)
}

class GenresRepository: GenresRepositoryProtocol {
    private let apiManager: APIManagerService

    init(apiManager: APIManagerService = APIManager()) {
        self.apiManager = apiManager
    }

    func getGenres(completion: @escaping (Result<[MovieGenre], Error>) -> Void) {
        guard let url = TMDBAPIService.getGenresURLString() else { return }

        apiManager.fetchItems(url: url) { (result: Result<MoviesGenreResponse, Error>) in
            switch result {
            case .success(let data):
                completion(.success(data.genres))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
