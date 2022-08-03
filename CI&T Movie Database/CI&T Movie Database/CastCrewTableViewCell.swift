//
//  Cast_CrewTableViewCell.swift
//  CI&T Movie Database
//
//  Created by Gilberto Junior on 25/07/22.
//

import UIKit

class CastCrewTableViewCell: UITableViewCell {
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var realName: UILabel!
    @IBOutlet var threeDotsImageView: UIImageView!
    @IBOutlet var charName: UILabel!

    func configure(_ castAndCrew: CastAndCrew) {
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
        profileImageView.clipsToBounds = true
        profileImageView.kf.indicatorType = .activity
        profileImageView.kf.setImage(with: castAndCrew.profileURL)
    }
}
