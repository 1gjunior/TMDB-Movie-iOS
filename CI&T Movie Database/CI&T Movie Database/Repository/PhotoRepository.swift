//
//  PhotoRepository.swift
//  CI&T Movie Database
//
//  Created by Gilberto Junior on 10/08/22.
//

import Foundation

protocol PhotoRepositoryProtocol {
    func getPhotosBy(movieId: Int, completion: @escaping (Result<[MovieImages], Error>) -> Void)
}

class PhotoRepository: PhotoRepositoryProtocol {
    private let apiManager: APIManagerService

    init(apiManager: APIManagerService = APIManager()) {
        self.apiManager = apiManager
    }

    func getPhotosBy(movieId: Int, completion: @escaping (Result<[MovieImages], Error>) -> Void) {
        guard let url = TMDBAPIService.getPhotosURLString(id: movieId) else { return }

        apiManager.fetchItems(url: url) { (result: Result<MovieImagesResponse, Error>) in
            switch result {
            case .success(let data):
                completion(.success(data.backdrops))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
