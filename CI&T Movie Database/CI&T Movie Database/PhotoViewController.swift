//
//  PhotoViewController.swift
//  CI&T Movie Database
//
//  Created by Gilberto Junior on 20/07/22.
//

import UIKit

class PhotoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var table: UITableView!

    struct MovieImage {
        let title: String
        let imageName: String
    }

    let data: [MovieImage] = [
        MovieImage(title: "image 1", imageName: "image 1"),
        MovieImage(title: "image 2", imageName: "image 2"),
        MovieImage(title: "image 3", imageName: "image 3"),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return data.count
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let photoMovie = data[indexPath.row]
        let photoCell = table.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as! PhotoTableViewCell

        photoCell.photoImageView.image = UIImage(named: photoMovie.imageName)

        return photoCell
    }

//    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
//        return 224
//    }
}
