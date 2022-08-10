//
//  MovieDetailViewModel.swift
//  CI&T Movie Database
//
//  Created by Gilberto Junior on 10/08/22.
//

import Combine
import Foundation

public class MovieDetailViewModel {
    private let movieDetailRepository: MovieDetailRepositoryProtocol

    var movieDetailSubject = PassthroughSubject<MovieDetail, Error>()

    init(movieDetailRepository: MovieDetailRepositoryProtocol = MovieDetailRepository()) {
        self.movieDetailRepository = movieDetailRepository
    }

    func getMovieDetailBy(movieId: Int) {
        movieDetailRepository.getMovieDetailsBy(movieId: movieId) { [weak self] (result: Result<MovieDetail, Error>) in
            switch result {
            case .success(let data):
                self?.movieDetailSubject.send(data)
            case .failure(let error):
                self?.movieDetailSubject.send(completion: .failure(error))
            }
        }
    }
}
