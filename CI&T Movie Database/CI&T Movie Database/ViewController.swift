//
//  ViewController.swift
//  CI&T Movie Database
//
//  Created by Gilberto Jose de Sousa Silva Junior on 12/07/22.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        let horror = Genre(id: 1, name: "Horror")
        let action = Genre(id: 2, name: "Action")
        let romance = Genre(id: 3, name: "Romance")
        let comedy = Genre(id: 4, name: "Comedy")

        let justiceLeague = Movie(id: 1, voteAverage: 8.8, title: "Justice League", originalTitle: "Justice League", popularity: 9.0, posterPath: "JL poster", backdropPath: "jl back", overview: "is a hero movie", releaseDate: "18-03-2021", genres: [action])
        let guardiansOfTheGalaxy = Movie(id: 2, voteAverage: 7.9, title: "Guardians of the Galaxy", originalTitle: "Guardians of the Galaxy", popularity: 7.9, posterPath: "gotg poster", backdropPath: "gotg back", overview: "is a hero movie", releaseDate: "31-07-2014", genres: [action, comedy])
        let quietPlace = Movie(id: 3, voteAverage: 7.5, title: "Quiet Place", originalTitle: "Quiet Place", popularity: 7.5, posterPath: "qp poster", backdropPath: "qp background", overview: "a action horror movie", releaseDate: "03-04-2018", genres: [horror])

        let movies = MovieDatabase(movies: [justiceLeague, guardiansOfTheGalaxy, quietPlace])

        let actionMovies = movies.getMoviesByGenre(genre: action)
        let romanceMovies = movies.getMoviesByGenre(genre: romance)

        print(actionMovies, romanceMovies, movies.getMoviesOrderedByReleaseDate(), movies.getMoviesOrderedByAlphabeticalOrder(), separator: "\n\n ---------------------- \n\n")
    }
}
