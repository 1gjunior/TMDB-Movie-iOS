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
        setupViewModel()
        observeViewModel()
        getPhotosBy(movieId: movieId)
        photoDetailCollectionView.dataSource = self
        photoDetailCollectionView.delegate = self
        fetchMovieDetail()
    }

    private func setupViewModel() {
        photoViewModel = PhotoViewModel()
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
