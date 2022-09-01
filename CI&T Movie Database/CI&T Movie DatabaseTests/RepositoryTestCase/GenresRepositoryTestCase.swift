//
//  GenresRepositoryTestCase.swift
//  CI&T Movie DatabaseTests
//
//  Created by Gilberto Junior on 01/09/22.
//

import XCTest
@testable import CI_T_Movie_Database

class GenresRepositoryTestCase: XCTestCase {

    let mock = APIManagerServiceMock()
    var repository: GenresRepository!
    var url: URL?
    
    override func setUp() {
        repository = GenresRepository(apiManager: mock)
    }
 
    func testApiManagerError() {
        mock.error = NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "Error"])
        
        repository.getGenres(completion: { result in
            switch result {
            case .success:
                XCTFail()
            case .failure:
                XCTAssertNotNil(self.mock.error)
            }
        })
    }
    
    func testApiManager() {
        let genres = [MovieGenre(id: 182, name: "The Office")]
        
        mock.item = MoviesGenreResponse(genres: genres)
        
        repository.getGenres(completion: { result in
            switch result {
            case .success:
                XCTAssertNotNil(self.mock.item)
            case .failure:
                XCTFail()
            }
        })
    }

}
