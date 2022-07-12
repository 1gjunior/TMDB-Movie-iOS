//
//  MovieDatabase.swift
//  CI&T Movie Database
//
//  Created by Gilberto Jose de Sousa Silva Junior on 12/07/22.
//

import Foundation

struct MovieDatabase {
    var movies: [Movie] = []

    func getMoviesByGenre(genre: Genre) -> [Movie] {
        movies.filter { movie in
            movie.genres.contains(genre)
        }
    }

    func getMoviesOrderedByReleaseDate() -> [Movie] {
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "dd-MM-yyyy"

        return movies.sorted {
            dateFormatter.date(from: $0.releaseDate)! < dateFormatter.date(from: $1.releaseDate)!
        }
    }

    func getMoviesOrderedByAlphabeticalOrder() -> [Movie] {
        movies.sorted {
            $0.title < $1.title
        }
    }
}
