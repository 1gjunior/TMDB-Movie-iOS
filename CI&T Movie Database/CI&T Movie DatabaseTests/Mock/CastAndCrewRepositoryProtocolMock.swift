///
/// @Generated by Mockolo
///

import Foundation
@testable import CI_T_Movie_Database

class CastAndCrewRepositoryProtocolMock: CastAndCrewRepositoryProtocol {
    var model: [CastAndCrew] = []
    var error: Error! = nil
    
    private(set) var getCastAndCrewByCallCount = 0
    var getCastAndCrewByHandler: ((Int, @escaping (Result<[CastAndCrew], Error>) -> Void) -> Void)?
    func getCastAndCrewBy(movieId: Int, completion: @escaping (Result<[CastAndCrew], Error>) -> Void) {
        getCastAndCrewByCallCount += 1
        if let getCastAndCrewByHandler = getCastAndCrewByHandler {
            getCastAndCrewByHandler(movieId, completion)
        }
        
        if let error = error {
            completion(.failure(error))
        } else {
            completion(.success(model))
        }
    }
}
