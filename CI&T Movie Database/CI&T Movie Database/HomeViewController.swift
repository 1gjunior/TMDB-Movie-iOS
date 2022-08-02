//
//  HomeViewController.swift
//  CI&T Movie Database
//
//  Created by Gilberto Junior on 25/07/22.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    @IBOutlet var movieSegmentedControl: UISegmentedControl! {
        didSet {
            movieSegmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        }
    }

    func fetchGenres() {
        URLSession.shared.dataTask(with: URL(string: "https://api.themoviedb.org/3/genre/movie/list?api_key=a5a29cab08554d8a0b331b250a19170b")!, completionHandler: { data, _, error in

            guard let data = data, error == nil else {
                return
            }
            var result: MoviesGenreResponse?
            do {
                result = try JSONDecoder().decode(MoviesGenreResponse.self, from: data)
            } catch {
                print(error)
            }

            guard let finalResult = result?.genres else { return }
            self.genres.append(contentsOf: finalResult)
//            print(finalResult)

        }).resume()
    }

    func fetchMovies() {
        URLSession.shared.dataTask(with: URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a5a29cab08554d8a0b331b250a19170b")!, completionHandler: { data, _, error in

            guard let data = data, error == nil else {
                return
            }
            var result: MoviesResponse?
            do {
                result = try JSONDecoder().decode(MoviesResponse.self, from: data)
            } catch {
                print(error)
            }

            guard let finalResult = result?.results else { return }
//            print(finalResult)
            self.data.append(contentsOf: finalResult)
            self.nowPlayingMovies.append(contentsOf: finalResult)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }).resume()

        URLSession.shared.dataTask(with: URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=a5a29cab08554d8a0b331b250a19170b")!, completionHandler: { data, _, error in

            guard let data = data, error == nil else {
                return
            }
            var result: MoviesResponse?
            do {
                result = try JSONDecoder().decode(MoviesResponse.self, from: data)
            } catch {
                print(error)
            }

            guard let finalResult = result?.results else { return }
//            print(finalResult)
            self.comingSoonMoves.append(contentsOf: finalResult)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }).resume()
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

    lazy var nowPlayingMovies: [Movie] = []

    lazy var comingSoonMoves: [Movie] = []

    lazy var data: [Movie] = []

    lazy var genres: [MovieGenre] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        let layout = UICollectionViewFlowLayout()
        collectionView.collectionViewLayout = layout

        collectionView.dataSource = self
        collectionView.delegate = self
        fetchGenres()
        fetchMovies()
    }

    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movie = data[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCell", for: indexPath) as! HomeCollectionViewCell

        cell.titleLabel.text = movie.title
        cell.releaseDateLabel.text = movie.releaseDate
        cell.voteAverageLabel.text = String(format: "%.1f", movie.voteAverage)

        let movieGenre = genres.filter { $0.id == movie.genreIds.first }

        cell.genreLabel.text = movieGenre.first?.name
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
