//
//  Movie.swift
//  CI&T Movie Database
//
//  Created by Gilberto Jose de Sousa Silva Junior on 12/07/22.
//

import Foundation

struct MoviesResponse: Codable {
    let page: Int
    let totalResults: Int
    let totalPages: Int
    let results: [Movie]

    private enum CodingKeys: String, CodingKey {
        case page, results, totalResults = "total_results", totalPages = "total_pages"
    }
}

struct Movie: Codable {
    let id: Int
    let title: String
    let backdropPath: String?
    let posterPath: String?
    let overview: String
    let releaseDate: String
    let voteAverage: Double
    let voteCount: Int
    let tagline: String?
    let genres: [MovieGenre]?
    var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w185\(posterPath ?? "")")!
    }

    var backdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/original\(backdropPath ?? "")")!
    }

    private enum CodingKeys: String, CodingKey {
        case id, title, backdropPath = "backdrop_path", posterPath = "poster_path", overview, releaseDate = "release_date", voteAverage = "vote_average", voteCount = "vote_count", tagline, genres
    }
}

struct MovieGenre: Codable {
    let name: String
}

struct MovieCast: Codable {
    public let character: String
    public let name: String
}

struct MovieCrew: Codable {
    public let id: Int
    public let department: String
    public let job: String
    public let name: String
}
