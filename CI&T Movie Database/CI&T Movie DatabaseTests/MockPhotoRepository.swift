//
//  MockPhotoRepository.swift
//  CI&T Movie DatabaseTests
//
//  Created by Gilberto Junior on 31/08/22.
//

@testable import CI_T_Movie_Database
import Foundation

final class MockPhotoRepository: PhotoRepositoryProtocol {
    func getPhotosBy(movieId: Int, completion: @escaping (Result<[MovieImages], Error>) -> Void) {}
}
