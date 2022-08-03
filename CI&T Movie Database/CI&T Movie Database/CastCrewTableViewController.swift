//
//  Cast&CrewTableViewController.swift
//  CI&T Movie Database
//
//  Created by Gilberto Junior on 25/07/22.
//

import Kingfisher
import UIKit

class CastCrewTableViewController: UITableViewController {
    var data: [CastAndCrew] = []
    var movieId: Int = 0

    @IBOutlet var table: UITableView!

    func fetchCastAndCrew() {
        URLSession.shared.dataTask(with: URL(string: "https://api.themoviedb.org/3/movie/\(movieId)/credits?api_key=a5a29cab08554d8a0b331b250a19170b")!, completionHandler: { data, _, error in

            guard let data = data, error == nil else {
                return
            }
            var result: MovieCastAndCrewResponse?
            do {
                result = try JSONDecoder().decode(MovieCastAndCrewResponse.self, from: data)
            } catch {
                print(error)
            }

            guard let finalResult = result else { return }

            DispatchQueue.main.async {
                self.data = finalResult.cast
                self.data += finalResult.crew
                self.tableView.reloadData()
            }

        }).resume()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
        fetchCastAndCrew()
    }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let castAndCrew = data[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "castCell", for: indexPath) as! CastCrewTableViewCell

        cell.realName.text = castAndCrew.name
        cell.charName.text = castAndCrew.character
        cell.configure(castAndCrew)

        return cell
    }
}
