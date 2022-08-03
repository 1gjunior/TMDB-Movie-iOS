//
//  MovieDetailViewController.swift
//  CI&T Movie Database
//
//  Created by Gilberto Junior on 26/07/22.
//

import Kingfisher
import UIKit

class MovieDetailViewController: UIViewController {
    var movieId: Int = 0

    @IBOutlet var textView: UITextView!
    @IBOutlet var movieTitle: UILabel!
    @IBOutlet var movieVoteAverage: UILabel!
    @IBOutlet var movieImageView: UIImageView!
    @IBOutlet var movieDuration: UILabel!
    @IBOutlet var movieGenres: UILabel!
    @IBOutlet var movieIsAdult: UILabel!

    @IBOutlet var showButton: UIButton!
    @IBOutlet var textViewHeight: NSLayoutConstraint!
    @IBAction func showButtonClick(_ sender: UIButton) {
        if sender.tag == 0 {
            textViewHeight.constant = textView.contentSize.height
            showButton.setTitle("Show Less", for: .normal)
            sender.tag = 1
        } else {
            textViewHeight.constant = 128
            showButton.setTitle("Show More", for: .normal)
            sender.tag = 0
        }
    }

    func fetchMovieDetail() {
        URLSession.shared.dataTask(with: URL(string: "https://api.themoviedb.org/3/movie/\(movieId)?api_key=a5a29cab08554d8a0b331b250a19170b")!, completionHandler: { data, _, error in

            guard let data = data, error == nil else {
                return
            }
            var result: MovieDetail?
            do {
                result = try JSONDecoder().decode(MovieDetail.self, from: data)
            } catch {
                print(error)
            }

            guard let finalResult = result else { return }
            DispatchQueue.main.async {
                self.textView.text = finalResult.overview
                self.movieTitle.text = finalResult.title
                self.movieVoteAverage.text = String(format: "%.1f", finalResult.voteAverage)
                self.movieImageView.kf.indicatorType = .activity
                self.movieImageView.kf.setImage(with: finalResult.backdropURL)
                self.movieDuration.text = finalResult.duration
                self.movieIsAdult.text = finalResult.adult ? "R" : ""

                var genreNames: [String] = []

                for genre in finalResult.genres! {
                    genreNames.append(genre.name)
                }

                self.movieGenres.text = genreNames.joined(separator: ", ")
            }

        }).resume()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMovieDetail()
    }

    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        if let destinationVC = segue.destination as? CastCrewTableViewController,
           segue.identifier == "castAndCrewSegue" || segue.identifier == "castAndCrewButtonSegue"
        {
            destinationVC.movieId = movieId
        }
    }
}
