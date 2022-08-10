//
//  CastCrewViewModel.swift
//  CI&T Movie Database
//
//  Created by Gilberto Junior on 09/08/22.
//

import Combine
import Foundation

class CastCrewViewModel {
    private let apiManager: APIManagerService
    private let endpoint: Endpoint

    var castAndCrewSubject = PassthroughSubject<[CastAndCrew], Error>()

    init(apiManager: APIManagerService, endpoint: Endpoint) {
        self.apiManager = apiManager
        self.endpoint = endpoint
    }

    func fetchCastAndCrew() {
        let url = URL(string: endpoint.urlString)!
        var castAndCrew: [CastAndCrew] = []

        apiManager.fetchItems(url: url) { [weak self] (result: Result<MovieCastAndCrewResponse, Error>) in
            switch result {
            case .success(let data):
                castAndCrew = data.cast
                castAndCrew += data.crew
                self?.castAndCrewSubject.send(castAndCrew)
            case .failure(let error):
                self?.castAndCrewSubject.send(completion: .failure(error))
            }
        }
    }
}
