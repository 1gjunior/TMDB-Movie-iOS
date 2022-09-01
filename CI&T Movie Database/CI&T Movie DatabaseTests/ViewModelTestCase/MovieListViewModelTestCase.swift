//
//  MovieListViewModelTestCase.swift
//  CI&T Movie DatabaseTests
//
//  Created by Gilberto Junior on 31/08/22.
//

@testable import CI_T_Movie_Database
import Combine
import XCTest

class MovieListViewModelTestCase: XCTestCase {
    var viewModel: MovieListViewModel!
    var movieListMock = MovieListRepositoryProtocolMock()
    var genresMock = GenresRepositoryProtocolMock()
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() async throws {
        cancellables = []
        viewModel = MovieListViewModel(movieListRepository: movieListMock, genresRepository: genresMock)
    }
    
    override func tearDown() async throws {
        viewModel = nil
    }
    
    func test_now_playing_error() {
        // MARK: - Given
        
        movieListMock.error = NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "Error"])
        
        // MARK: Then
        
        viewModel.nowPlayingMoviesSubject.sink(receiveCompletion: { result in
            XCTAssertNotNil(result)
        }, receiveValue: { _ in
            XCTFail("Error test_error MovieListViewModelTestCase")
        }).store(in: &cancellables)
        
        // MARK: When

        viewModel.getNowPlayingMovies()
        XCTAssertEqual(movieListMock.getNowPlayingMoviesCallCount, 1)
        XCTAssertEqual(genresMock.getGenresCallCount, 1)
    }
    
    func test_now_playing_success() {
        // MARK: - Given
        
        let data = [Movie(id: 539681, title: "Dragon Ball Super: Super Hero", backdropPath: "/xfNHRI2f5kHGvogxLd0C5sB90L7.jpg", posterPath: "/r7XifzvtezNt31ypvsmb6Oqxw49.jpg", overview: "a simple movie", releaseDate: "2022-06-11", voteAverage: 7.1, voteCount: 785, tagline: nil, genreIds: [16, 878, 28])]
        
        movieListMock.model = data
        
        // MARK: - Then

        viewModel.nowPlayingMoviesSubject.sink(receiveCompletion: { _ in
            XCTFail("Error test_success MovieListViewModelTestCase")
        }, receiveValue: { result in
            XCTAssertEqual(result.count, 1)
        }).store(in: &cancellables)
        
        // MARK: - When

        viewModel.getNowPlayingMovies()
        XCTAssertEqual(movieListMock.getNowPlayingMoviesCallCount, 1)
        XCTAssertEqual(genresMock.getGenresCallCount, 1)
    }

    func test_upcoming_error() {
        // MARK: - Given
        
        movieListMock.error = NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "Error"])
        
        // MARK: Then
        
        viewModel.upcomingMoviesSubject.sink(receiveCompletion: { result in
            XCTAssertNotNil(result)
        }, receiveValue: { _ in
            XCTFail("Error test_error MovieListViewModelTestCase")
        }).store(in: &cancellables)
        
        // MARK: When

        viewModel.getUpcomingMovies()
        XCTAssertEqual(movieListMock.getUpcomingMoviesCallCount, 1)
        XCTAssertEqual(genresMock.getGenresCallCount, 1)
    }
    
    func test_upcoming_success() {
        // MARK: - Given
        
        let data = [Movie(id: 539681, title: "Dragon Ball Super: Super Hero", backdropPath: "/xfNHRI2f5kHGvogxLd0C5sB90L7.jpg", posterPath: "/r7XifzvtezNt31ypvsmb6Oqxw49.jpg", overview: "a simple movie", releaseDate: "2022-06-11", voteAverage: 7.1, voteCount: 785, tagline: nil, genreIds: [16, 878, 28])]
        
        movieListMock.model = data
        
        // MARK: - Then

        viewModel.upcomingMoviesSubject.sink(receiveCompletion: { _ in
            XCTFail("Error test_success MovieListViewModelTestCase")
        }, receiveValue: { result in
            XCTAssertEqual(result.count, 1)
        }).store(in: &cancellables)
        
        // MARK: - When

        viewModel.getUpcomingMovies()
        XCTAssertEqual(movieListMock.getUpcomingMoviesCallCount, 1)
        XCTAssertEqual(genresMock.getGenresCallCount, 1)
    }
}
