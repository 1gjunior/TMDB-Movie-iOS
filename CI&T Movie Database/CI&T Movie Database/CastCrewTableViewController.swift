//
//  Cast&CrewTableViewController.swift
//  CI&T Movie Database
//
//  Created by Gilberto Junior on 25/07/22.
//

import UIKit

class CastCrewTableViewController: UITableViewController {
    @IBOutlet var table: UITableView!

    struct Cast {
        let profileImage: String
        let realName: String
        let threeDots: String
        let charName: String
    }

    let data: [Cast] = [
        Cast(profileImage: "Keanu_Reeves", realName: "Keanu Reeves", threeDots: "Three_Dots", charName: "John Wick"),
        Cast(profileImage: "Halle_Berry", realName: "Halle Berry", threeDots: "Three_Dots", charName: "Sofia"),
        Cast(profileImage: "Laurence_Fishburne", realName: "Laurence Fishburne", threeDots: "Three_Dots", charName: "Bowery King"),
        Cast(profileImage: "Mark_Dacascos", realName: "Mark Dacascos", threeDots: "Three_Dots", charName: "Zero"),
        Cast(profileImage: "Asia_Kate_Dillon", realName: "Asia Kate Dillon", threeDots: "Three_Dots", charName: "Adjudicator"),
        Cast(profileImage: "Lance_Reddick", realName: "Lance Reddick", threeDots: "Three_Dots", charName: "Charon"),
        Cast(profileImage: "Anjelica_Huston", realName: "Anjelica Huston", threeDots: "Three_Dots", charName: "Director"),
        Cast(profileImage: "Margaret_Daly", realName: "Margaret Daly", threeDots: "Three_Dots", charName: "Operator"),
        Cast(profileImage: "Jerome_Flynn", realName: "Jerome Flynn", threeDots: "Three_Dots", charName: "Berrada"),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
    }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cast = data[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "castCell", for: indexPath) as! CastCrewTableViewCell

        cell.profileImageView.image = UIImage(named: cast.profileImage)
        cell.realName.text = cast.realName
        cell.threeDotsImageView.image = UIImage(named: cast.threeDots)
        cell.charName.text = cast.charName.uppercased()

        return cell
    }
}
