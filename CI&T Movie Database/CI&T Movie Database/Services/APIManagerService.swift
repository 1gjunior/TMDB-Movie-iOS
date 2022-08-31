//
//  APIManagerService.swift
//  CI&T Movie Database
//
//  Created by Gilberto Junior on 09/08/22.
//

import Combine
import Foundation

/// @mockable
protocol APIManagerService {
    func fetchItems<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void)
}

class APIManager: APIManagerService {
    private var subscribers = Set<AnyCancellable>()

    func fetchItems<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        URLSession.shared.dataTaskPublisher(for: url).map { $0.data }.decode(type: T.self, decoder: JSONDecoder()).sink(receiveCompletion: { resultCompletion in
            switch resultCompletion {
            case .failure(let error):
                completion(.failure(error))
            case .finished: break
            }
        }, receiveValue: { resultArray in
            completion(.success(resultArray))
        }).store(in: &subscribers)
    }
}
