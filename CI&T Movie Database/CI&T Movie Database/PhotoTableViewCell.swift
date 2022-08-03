//
//  PhotoTableViewCell.swift
//  CI&T Movie Database
//
//  Created by Gilberto Junior on 20/07/22.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {
    @IBOutlet var photoImageView: UIImageView!
    
    func configure(_ photo: MovieImages) {
        photoImageView.kf.indicatorType = .activity
        photoImageView.kf.setImage(with: photo.fileURL)
    }
}
