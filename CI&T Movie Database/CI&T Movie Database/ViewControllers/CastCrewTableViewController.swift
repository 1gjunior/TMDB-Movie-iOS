//
//  Cast&CrewTableViewController.swift
//  CI&T Movie Database
//
//  Created by Gilberto Junior on 25/07/22.
//

import Combine
import UIKit

class CastCrewTableViewController: UITableViewController {
    var viewModel: CastAndCrewViewModel!

    private let apiManager = APIManager()
    private var subscriber: AnyCancellable?

    var data: [CastAndCrew] = []
    var movieId: Int = 0

    @IBOutlet var table: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        observeViewModel()
        getCastAndCrewBy(movieId: movieId)
    }

    // MARK: - Private Methods

    private func setupViewModel() {
        viewModel = CastAndCrewViewModel()
    }

    private func getCastAndCrewBy(movieId: Int) {
        viewModel.getCastAndCrewBy(movieId: movieId)
    }

    private func observeViewModel() {
        subscriber = viewModel.castAndCrewSubject.sink { resultCompletion in
            switch resultCompletion {
            case .failure(let error):
                print(error.localizedDescription)
            default: break
            }
        } receiveValue: { castAndCrew in
            DispatchQueue.main.async {
                self.data = castAndCrew
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Data Source

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let castAndCrew = data[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "castCell", for: indexPath) as! CastCrewTableViewCell

        cell.configure(castAndCrew)

        return cell
    }
}
