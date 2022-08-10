//
//  MovieDetailViewController.swift
//  CI&T Movie Database
//
//  Created by Gilberto Junior on 26/07/22.
//

import Combine
import Kingfisher
import UIKit

class MovieDetailViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    var movieDetailViewModel: MovieDetailViewModel!
    var photoViewModel: PhotoViewModel!

    private var subscribers: Set<AnyCancellable> = []

    var movieId: Int = 0
    var movieImages: [MovieImages] = []

    @IBOutlet var photoDetailCollectionView: UICollectionView!

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

    override func viewDidLoad() {
        super.viewDidLoad()
        photoDetailCollectionView.dataSource = self
        photoDetailCollectionView.delegate = self
        setupViewModel()
        observeViewModel()
        getMovieDetailBy(movieId: movieId)
        getPhotosBy(movieId: movieId)
    }

    // MARK: - Private Methods

    private func setupViewModel() {
        movieDetailViewModel = MovieDetailViewModel()
        photoViewModel = PhotoViewModel()
    }

    private func getMovieDetailBy(movieId: Int) {
        movieDetailViewModel.getMovieDetailBy(movieId: movieId)
    }

    private func getPhotosBy(movieId: Int) {
        photoViewModel.getPhotosBy(movieId: movieId)
    }

    private func observeViewModel() {
        photoViewModel.photoSubject.sink { resultCompletion in
            switch resultCompletion {
            case let .failure(error):
                print(error.localizedDescription)
            default: break
            }
        } receiveValue: { photos in
            DispatchQueue.main.async {
                self.movieImages = photos
                self.photoDetailCollectionView.reloadData()
            }
        }.store(in: &subscribers)

        movieDetailViewModel.movieDetailSubject.sink { resultCompletion in
            switch resultCompletion {
            case let .failure(error):
                print(error.localizedDescription)
            default: break
            }
        } receiveValue: { movieDetail in
            DispatchQueue.main.async {
                self.textView.text = movieDetail.overview
                self.movieTitle.text = movieDetail.title
                self.movieVoteAverage.text = String(format: "%.1f", movieDetail.voteAverage)
                self.movieImageView.kf.indicatorType = .activity
                self.movieImageView.kf.setImage(with: movieDetail.backdropURL)
                self.movieDuration.text = movieDetail.duration
                self.movieIsAdult.text = movieDetail.adult ? "R" : ""

                var genreNames: [String] = []

                for genre in movieDetail.genres! {
                    genreNames.append(genre.name)
                }

                self.movieGenres.text = genreNames.joined(separator: ", ")
            }
        }.store(in: &subscribers)
    }

    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        if let castAndCrewVC = segue.destination as? CastAndCrewTableViewController,
           segue.identifier == "castAndCrewSegue" || segue.identifier == "castAndCrewButtonSegue"
        {
            castAndCrewVC.movieId = movieId
        }
        if let photoVC = segue.destination as? PhotoViewController {
            photoVC.movieImages = movieImages
        }
    }

    // MARK: - Data Source

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieImages.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let photo = movieImages[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoDetailCell", for: indexPath) as! PhotoDetailCollectionViewCell

        cell.configure(photo)
        return cell
    }
}
