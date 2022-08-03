//
//  PhotoViewController.swift
//  CI&T Movie Database
//
//  Created by Gilberto Junior on 20/07/22.
//

import UIKit

class PhotoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var movieImages: [MovieImages] = []

    @IBOutlet var table: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return movieImages.count
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let photo = movieImages[indexPath.row]
        let cell = table.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as! PhotoTableViewCell

        cell.configure(photo)
        return cell
    }
}
