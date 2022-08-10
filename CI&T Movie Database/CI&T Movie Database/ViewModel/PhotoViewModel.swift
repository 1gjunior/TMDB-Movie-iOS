//
//  PhotoViewModel.swift
//  CI&T Movie Database
//
//  Created by Gilberto Junior on 10/08/22.
//

import Combine
import Foundation

public class PhotoViewModel {
    private let photoRepository: PhotoRepositoryProtocol

    var photoSubject = PassthroughSubject<[MovieImages], Error>()

    init(photoRepository: PhotoRepositoryProtocol = PhotoRepository()) {
        self.photoRepository = photoRepository
    }

    func getPhotosBy(movieId: Int) {
        photoRepository.getPhotosBy(movieId: movieId) { [weak self] (result: Result<[MovieImages], Error>) in
            switch result {
            case .success(let data):
                self?.photoSubject.send(data)
            case .failure(let error):
                self?.photoSubject.send(completion: .failure(error))
            }
        }
    }
}
