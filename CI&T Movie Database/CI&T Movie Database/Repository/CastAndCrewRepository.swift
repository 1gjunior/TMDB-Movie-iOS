//
//  CastAndCrewRepository.swift
//  CI&T Movie Database
//
//  Created by Gilberto Junior on 10/08/22.
//

import Foundation

protocol CastAndCrewRepositoryProtocol {
    func getCastAndCrewBy(movieId: Int, completion: @escaping (Result<[CastAndCrew], Error>) -> Void)
}

class CastAndCrewRepository: CastAndCrewRepositoryProtocol {
    private let apiManager: APIManagerService

    init(apiManager: APIManagerService = APIManager()) {
        self.apiManager = apiManager
    }

    func getCastAndCrewBy(movieId: Int, completion: @escaping (Result<[CastAndCrew], Error>) -> Void) {
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)/credits?api_key=a5a29cab08554d8a0b331b250a19170b")!

        apiManager.fetchItems(url: url) { (result: Result<MovieCastAndCrewResponse, Error>) in
            switch result {
            case .success(let data):
                completion(.success(data.cast + data.crew))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
