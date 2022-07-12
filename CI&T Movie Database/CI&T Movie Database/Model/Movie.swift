//
//  Movie.swift
//  CI&T Movie Database
//
//  Created by Gilberto Jose de Sousa Silva Junior on 12/07/22.
//

import Foundation

struct Movie {
    let id: Int
    let voteAverage: Double
    let title: String
    let originalTitle: String
    let popularity: Double
    let posterPath: String
    let backdropPath: String
    let overview: String
    let releaseDate: String
    let genres: [Genre]
}
