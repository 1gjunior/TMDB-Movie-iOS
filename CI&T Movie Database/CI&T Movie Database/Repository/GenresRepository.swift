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
        let url = URL(string: "https://api.themoviedb.org/3/genre/movie/list?api_key=a5a29cab08554d8a0b331b250a19170b")!

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
