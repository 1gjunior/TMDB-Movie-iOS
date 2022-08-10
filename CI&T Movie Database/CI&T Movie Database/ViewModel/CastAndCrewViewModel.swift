//
//  CastCrewViewModel.swift
//  CI&T Movie Database
//
//  Created by Gilberto Junior on 09/08/22.
//

import Combine
import Foundation

public class CastAndCrewViewModel {
    private let castAndCrewRepository: CastAndCrewRepositoryProtocol

    var castAndCrewSubject = PassthroughSubject<[CastAndCrew], Error>()

    init(castAndCrewRepository: CastAndCrewRepositoryProtocol = CastAndCrewRepository()) {
        self.castAndCrewRepository = castAndCrewRepository
    }

    func getCastAndCrewBy(movieId: Int) {
        castAndCrewRepository.getCastAndCrewBy(movieId: movieId) { [weak self] (result: Result<[CastAndCrew], Error>) in
            switch result {
            case .success(let data):
                self?.castAndCrewSubject.send(data)
            case .failure(let error):
                self?.castAndCrewSubject.send(completion: .failure(error))
            }
        }
    }
}
