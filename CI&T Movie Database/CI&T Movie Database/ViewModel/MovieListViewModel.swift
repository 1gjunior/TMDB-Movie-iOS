//
//  MoviListViewModel.swift
//  CI&T Movie Database
//
//  Created by Gilberto Junior on 10/08/22.
//

import Combine
import Foundation

public class MovieListViewModel {
    private let movieListRepository: MovieListRepositoryProtocol
    private let genresRepository: GenresRepositoryProtocol

    private var genresList: [MovieGenre] = []

    var nowPlayingMoviesSubject = PassthroughSubject<[Movie], Error>()
    var upcomingMoviesSubject = PassthroughSubject<[Movie], Error>()

    init(movieListRepository: MovieListRepositoryProtocol = MovieListRepository(), genresRepository: GenresRepositoryProtocol = GenresRepository()) {
        self.movieListRepository = movieListRepository
        self.genresRepository = genresRepository

        getGenres()
    }

    func getGenres() {
        genresRepository.getGenres { [weak self] (result: Result<[MovieGenre], Error>) in
            switch result {
            case .success(let data):
                self?.genresList = data
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func getNowPlayingMovies() {
        movieListRepository.getNowPlayingMovies { [weak self] (result: Result<[Movie], Error>) in
            switch result {
            case .success(let data):
                let newData = data.map { item -> Movie in
                    var item = item
                    item.genres = self?.genresList.filter { $0.id == item.genreIds.first }
                    return item
                }
                self?.nowPlayingMoviesSubject.send(newData)
            case .failure(let error):
                self?.nowPlayingMoviesSubject.send(completion: .failure(error))
            }
        }
    }

    func getUpcomingMovies() {
        movieListRepository.getUpcomingMovies { [weak self] (result: Result<[Movie], Error>) in
            switch result {
            case .success(let data):
                let newData = data.map { item -> Movie in
                    var item = item
                    item.genres = self?.genresList.filter { $0.id == item.genreIds.first }
                    return item
                }
                self?.upcomingMoviesSubject.send(newData)
            case .failure(let error):
                self?.upcomingMoviesSubject.send(completion: .failure(error))
            }
        }
    }
}
