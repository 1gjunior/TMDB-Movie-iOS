///
/// @Generated by Mockolo
///

@testable import CI_T_Movie_Database
import Foundation

class PhotoRepositoryProtocolMock: PhotoRepositoryProtocol {
    var data: [MovieImages] = []
    var error: Error!

    private(set) var getPhotosByCallCount = 0
    var getPhotosByHandler: ((Int, @escaping (Result<[MovieImages], Error>) -> Void) -> Void)?
    func getPhotosBy(movieId: Int, completion: @escaping (Result<[MovieImages], Error>) -> Void) {
        getPhotosByCallCount += 1
        if let getPhotosByHandler = getPhotosByHandler {
            getPhotosByHandler(movieId, completion)
        }

        if let error = error {
            completion(.failure(error))
        } else {
            completion(.success(data))
        }
    }
}