//
//  HomeViewController.swift
//  CI&T Movie Database
//
//  Created by Gilberto Junior on 25/07/22.
//

import Combine
import UIKit

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    var nowPlayingMovies: [Movie] = []
    var comingSoonMoves: [Movie] = []
    var data: [Movie] = []
    var genres: [MovieGenre] = []
    var movieId: Int = 0

    private var viewModel: MovieListViewModel!
    private var subscribers: Set<AnyCancellable> = []

    @IBOutlet var movieSegmentedControl: UISegmentedControl! {
        didSet {
            movieSegmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        }
    }

    @IBAction func segmentedDidChange(_: UISegmentedControl) {
        if movieSegmentedControl.selectedSegmentIndex == 1 {
            data = comingSoonMoves
        } else {
            data = nowPlayingMovies
        }

        collectionView.reloadData()
    }

    @IBOutlet var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let layout = UICollectionViewFlowLayout()
        collectionView.collectionViewLayout = layout

        setupViewModel()
        observeViewModel()
        getNowPlayingMovies()
        getUpcomingMovies()
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    private func setupViewModel() {
        viewModel = MovieListViewModel()
    }

    private func getNowPlayingMovies() {
        viewModel.getNowPlayingMovies()
    }

    private func getUpcomingMovies() {
        viewModel.getUpcomingMovies()
    }

    private func observeViewModel() {
        viewModel.nowPlayingMoviesSubject.sink { resultCompletion in
            switch resultCompletion {
            case .failure(let error):
                print(error.localizedDescription)
            default: break
            }
        } receiveValue: { nowPlayingMovies in
            DispatchQueue.main.async {
                self.data = nowPlayingMovies
                self.nowPlayingMovies = nowPlayingMovies
                self.collectionView.reloadData()
            }
        }.store(in: &subscribers)

        viewModel.upcomingMoviesSubject.sink { resultCompletion in
            switch resultCompletion {
            case .failure(let error):
                print(error.localizedDescription)
            default: break
            }
        } receiveValue: { upcomingMovies in
            DispatchQueue.main.async {
                self.comingSoonMoves = upcomingMovies
                self.collectionView.reloadData()
            }
        }.store(in: &subscribers)
    }

    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        movieId = data[indexPath.row].id
        performSegue(withIdentifier: "movieDetailSegue", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        if let destinationVC = segue.destination as? MovieDetailViewController,
           segue.identifier == "movieDetailSegue"
        {
            destinationVC.movieId = movieId
        }
    }

    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movie = data[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCell", for: indexPath) as! HomeCollectionViewCell

//        let movieGenre = genres.filter { $0.id == movie.genreIds.first }

//        print(movie.genres)

//        cell.genreLabel.text = movie.genres?.first?.name
        cell.configure(movie)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize
    {
        let leftAndRightPaddings: CGFloat = 10.0
        let numberOfItemsPerRow: CGFloat = 2.0

        let width = (collectionView.frame.width - leftAndRightPaddings) / numberOfItemsPerRow
        return CGSize(width: width, height: 300)
    }
}
