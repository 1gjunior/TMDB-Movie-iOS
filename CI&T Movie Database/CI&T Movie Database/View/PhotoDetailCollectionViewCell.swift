//
//  PhotoDetailCollectionViewCell.swift
//  CI&T Movie Database
//
//  Created by Gilberto Junior on 03/08/22.
//

import UIKit
import Kingfisher

class PhotoDetailCollectionViewCell: UICollectionViewCell {
    @IBOutlet var photoDetailImageView: UIImageView!
    
    func configure(_ photo: MovieImages) {
        photoDetailImageView.kf.indicatorType = .activity
        photoDetailImageView.kf.setImage(with: photo.fileURL)
    }
}
