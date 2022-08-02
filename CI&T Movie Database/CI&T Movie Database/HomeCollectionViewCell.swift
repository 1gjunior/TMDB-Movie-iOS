//
//  HomeCollectionViewCell.swift
//  CI&T Movie Database
//
//  Created by Gilberto Junior on 25/07/22.
//

import Kingfisher
import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    @IBOutlet var movieImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var genreLabel: UILabel!
    @IBOutlet var middleDotLabel: UILabel!
    @IBOutlet var releaseDateLabel: UILabel!
    @IBOutlet var pipeLabel: UILabel!
    @IBOutlet var voteAverageLabel: UILabel!

    func configure(_ movie: Movie) {
        movieImageView.kf.setImage(with: movie.posterURL)
    }
}
