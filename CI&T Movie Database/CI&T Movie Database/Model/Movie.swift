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

struct MoviesGenreResponse: Codable {
    let genres: [MovieGenre]
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
    let genreIds: [Int]
    var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w154\(posterPath ?? "")")!
    }

    var backdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/original\(backdropPath ?? "")")!
    }

    private enum CodingKeys: String, CodingKey {
        case id, title, backdropPath = "backdrop_path", posterPath = "poster_path", overview, releaseDate = "release_date", voteAverage = "vote_average", voteCount = "vote_count", tagline, genres, genreIds = "genre_ids"
    }
}

struct MovieGenre: Codable {
    let id: Int
    let name: String
}

struct MovieCast: Codable {
    let character: String
    let name: String
}

struct MovieCrew: Codable {
    let id: Int
    let department: String
    let job: String
    let name: String
}

struct MovieDetail: Codable {
    let title: String
    let voteAverage: Double
    let backdropPath: String?
    let runtime: Int?
    let adult: Bool
    let genres: [MovieGenre]?
    let overview: String

    var backdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/original\(backdropPath ?? "")")!
    }
    
    var duration: String {
        let hours = Int(round(Double((runtime ?? 0)/60)))
        let minutes = (runtime ?? 0) % 60
        return "\(hours)hr \(minutes)m"
    }

    private enum CodingKeys: String, CodingKey {
        case title, backdropPath = "backdrop_path", voteAverage = "vote_average", adult, genres, overview, runtime
    }
}
