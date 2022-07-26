//
//  HomeViewController.swift
//  CI&T Movie Database
//
//  Created by Gilberto Junior on 25/07/22.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet var movieSegmentedControl: UISegmentedControl! {
        didSet {
            movieSegmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        }
    }

    @IBOutlet var collectionView: UICollectionView!

    struct MovieHome {
        let profileImageName: String
        let title: String
        let genre: String
        let middleDot: String = "·"
        let releaseDate: String
        let pipe: String = "|"
        let voteAverage: String
    }

    let data: [MovieHome] = [
        MovieHome(profileImageName: "john-wick-movie", title: "John Wick 3", genre: "Crime", releaseDate: "22-10-2019", voteAverage: "7.5"),
        MovieHome(profileImageName: "captain-marvel-movie", title: "Captain Marvel", genre: "Action", releaseDate: "16-11-2019", voteAverage: "9.5"),
        MovieHome(profileImageName: "john-wick-movie", title: "John Wick 3", genre: "Crime", releaseDate: "22-10-2019", voteAverage: "7.5"),
        MovieHome(profileImageName: "john-wick-movie", title: "John Wick 3", genre: "Crime", releaseDate: "22-10-2019", voteAverage: "7.5"),
        MovieHome(profileImageName: "captain-marvel-movie", title: "Captain Marvel", genre: "Action", releaseDate: "16-11-2019", voteAverage: "9.5"),
        MovieHome(profileImageName: "john-wick-movie", title: "John Wick 3", genre: "Crime", releaseDate: "22-10-2019", voteAverage: "7.5"),
        MovieHome(profileImageName: "john-wick-movie", title: "John Wick 3", genre: "Crime", releaseDate: "22-10-2019", voteAverage: "7.5"),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movieHome = data[indexPath.row]
        let homeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCell", for: indexPath) as! HomeCollectionViewCell
        homeCell.movieImageView.image = UIImage(named: movieHome.profileImageName)
        homeCell.titleLabel.text = movieHome.title
        homeCell.genreLabel.text = movieHome.genre
        homeCell.middleDotLabel.text = movieHome.middleDot
        homeCell.releaseDateLabel.text = movieHome.releaseDate
        homeCell.pipeLabel.text = movieHome.pipe
        homeCell.voteAverageLabel.text = movieHome.voteAverage

        return homeCell
    }
}
