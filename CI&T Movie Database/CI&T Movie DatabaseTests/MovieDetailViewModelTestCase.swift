//
//  MovieDetailViewModelTestCase.swift
//  CI&T Movie DatabaseTests
//
//  Created by Gilberto Junior on 31/08/22.
//

@testable import CI_T_Movie_Database
import Combine
import XCTest

class MovieDetailViewModelTestCase: XCTestCase {
    var viewModel: MovieDetailViewModel!
    var mock = MovieDetailRepositoryProtocolMock()
    var cancellables: Set<AnyCancellable>!

    override func setUp() async throws {
        cancellables = []
        viewModel = MovieDetailViewModel(movieDetailRepository: mock)
    }

    override func tearDown() async throws {
        viewModel = nil
    }

    func test_error() {
        // MARK: - Given

        mock.error = NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "Error"])

        // MARK: - Then

        viewModel.movieDetailSubject.sink(receiveCompletion: { result in
            XCTAssertNotNil(result)
        }, receiveValue: { _ in
            XCTFail("Error test_error PhotoViewModelTestCase")
        }).store(in: &cancellables)

        // MARK: - When

        viewModel.getMovieDetailBy(movieId: 119)
        XCTAssertEqual(mock.getMovieDetailsByCallCount, 1)
    }

    func test_success() {
        // MARK: - Given

        let data = MovieDetail(title: "The Office", voteAverage: 5.55, backdropPath: "/5XBzD5WuTyVQZeS4VI25z2moMeY.jpg", runtime: 147, adult: false, genres: nil, overview: "a simple movie")
        mock.model = data

        // MARK: - Then

        viewModel.movieDetailSubject.sink(receiveCompletion: { _ in
            XCTFail("Error test_success PhotoViewModelTestCase")
        }, receiveValue: { result in
            XCTAssertEqual(result.overview, "a simple movie")
        }).store(in: &cancellables)

        // MARK: - When

        viewModel.getMovieDetailBy(movieId: 119)
        XCTAssertEqual(mock.getMovieDetailsByCallCount, 1)
    }
}
