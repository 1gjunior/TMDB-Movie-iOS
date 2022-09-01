//
//  CastAndCrewRepositoryTestCase.swift
//  CI&T Movie DatabaseTests
//
//  Created by Gilberto Junior on 01/09/22.
//

@testable import CI_T_Movie_Database
import Combine
import XCTest

class CastAndCrewRepositoryTestCase: XCTestCase {
    let mock = APIManagerServiceMock()
    var repository: CastAndCrewRepository!
    var url: URL?
    
    override func setUp() {
        repository = CastAndCrewRepository(apiManager: mock)
    }
 
    func test_error() {
        mock.error = NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "Error"])
        
        repository.getCastAndCrewBy(movieId: 500, completion: { result in
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
        let castAndCrew = [CastAndCrew(adult: false, gender: 2, id: 182, name: "Steve Carell", originalName: "Steve Carell", popularity: 18.255, profilePath: "/5XBzD5WuTyVQZeS4VI25z2moMeY.jpg", character: "Michael Scott", job: "")]
        
        mock.item = MovieCastAndCrewResponse(id: 500, cast: castAndCrew, crew: castAndCrew)
        
        repository.getCastAndCrewBy(movieId: 500, completion: { result in
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
