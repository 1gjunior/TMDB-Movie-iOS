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
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cast = data[indexPath.row]
        let castCell = tableView.dequeueReusableCell(withIdentifier: "castCell", for: indexPath) as! CastCrewTableViewCell
        
        castCell.profileImageView.image = UIImage(named: cast.profileImage)
        castCell.realName.text = cast.realName
        castCell.threeDotsImageView.image = UIImage(named: cast.threeDots)
        castCell.charName.text = cast.charName.uppercased()

        return castCell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
