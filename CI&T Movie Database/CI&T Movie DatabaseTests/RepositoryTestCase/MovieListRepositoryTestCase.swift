//
//  MovieListRepositoryTestCase.swift
//  CI&T Movie DatabaseTests
//
//  Created by Gilberto Junior on 01/09/22.
//

@testable import CI_T_Movie_Database
import Combine
import XCTest

class MovieListRepositoryTestCase: XCTestCase {
    let mock = APIManagerServiceMock()
    var repository: MovieListRepository!
    var url: URL?
    
    override func setUp() {
        repository = MovieListRepository(apiManager: mock)
    }
 
    func test_now_playing_error() {
        mock.error = NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "Error"])
        
        repository.getNowPlayingMovies(completion: { result in
            switch result {
            case .success:
                XCTFail()
            case .failure:
                XCTAssertNotNil(self.mock.error)
            }
        })
    }
    
    func test_now_playing_success() {
        let nowPlaying = [Movie(id: 539681, title: "Dragon Ball Super: Super Hero", backdropPath: "/xfNHRI2f5kHGvogxLd0C5sB90L7.jpg", posterPath: "/r7XifzvtezNt31ypvsmb6Oqxw49.jpg", overview: "a simple movie", releaseDate: "2022-06-11", voteAverage: 7.1, voteCount: 785, tagline: nil, genreIds: [16, 878, 28])]
        
        mock.item = MoviesResponse(page: 2, totalResults: 500, totalPages: 20, results: nowPlaying)
        
        repository.getNowPlayingMovies(completion: { result in
            switch result {
            case .success:
                XCTAssertNotNil(self.mock.item)
            case .failure:
                XCTFail()
            }
        })
    }
    
    func test_upcoming_error() {
        mock.error = NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "Error"])
        
        repository.getUpcomingMovies(completion: { result in
            switch result {
            case .success:
                XCTFail()
            case .failure:
                XCTAssertNotNil(self.mock.error)
            }
        })
        XCTAssertEqual(mock.fetchItemsCallCount, 1)
    }
    
    func test_upcoming_success() {
        let upcoming = [Movie(id: 539681, title: "Dragon Ball Super: Super Hero", backdropPath: "/xfNHRI2f5kHGvogxLd0C5sB90L7.jpg", posterPath: "/r7XifzvtezNt31ypvsmb6Oqxw49.jpg", overview: "a simple movie", releaseDate: "2022-06-11", voteAverage: 7.1, voteCount: 785, tagline: nil, genreIds: [16, 878, 28])]
        
        mock.item = MoviesResponse(page: 2, totalResults: 500, totalPages: 20, results: upcoming)
        
        repository.getUpcomingMovies(completion: { result in
            switch result {
            case .success:
                XCTAssertNotNil(self.mock.item)
            case .failure:
                XCTFail()
            }
        })
        XCTAssertEqual(mock.fetchItemsCallCount, 1)
    }
}
