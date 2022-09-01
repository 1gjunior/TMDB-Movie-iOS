//
//  MovieDetailRepositoryTestCase.swift
//  CI&T Movie DatabaseTests
//
//  Created by Gilberto Junior on 01/09/22.
//

import XCTest
import Combine
@testable import CI_T_Movie_Database

class MovieDetailRepositoryTestCase: XCTestCase {

    let mock = APIManagerServiceMock()
    var repository: MovieDetailRepository!
    var url: URL?
    
    override func setUp() {
        repository = MovieDetailRepository(apiManager: mock)
    }
 
    func test_error() {
        mock.error = NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "Error"])
        
        repository.getMovieDetailsBy(movieId: 245, completion: { result in
            switch result {
            case .success:
                XCTFail()
            case .failure:
                XCTAssertNotNil(self.mock.error)
            }
        })
        XCTAssertEqual(mock.fetchItemsCallCount, 1)
    }
    
    func test_success() {
        mock.item = MovieDetail(title: "The Office", voteAverage: 5.55, backdropPath: "/5XBzD5WuTyVQZeS4VI25z2moMeY.jpg", runtime: 147, adult: false, genres: nil, overview: "a simple movie")
        
        repository.getMovieDetailsBy(movieId: 245, completion: { result in
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
