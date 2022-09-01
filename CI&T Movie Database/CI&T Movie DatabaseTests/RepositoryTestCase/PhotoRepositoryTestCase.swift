//
//  PhotoRepositoryTestCase.swift
//  CI&T Movie DatabaseTests
//
//  Created by Gilberto Junior on 01/09/22.
//

@testable import CI_T_Movie_Database
import Combine
import XCTest

class PhotoRepositoryTestCase: XCTestCase {
    let mock = APIManagerServiceMock()
    var repository: PhotoRepository!
    var url: URL?
    
    override func setUp() {
        repository = PhotoRepository(apiManager: mock)
    }
 
    func test_error() {
        mock.error = NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "Error"])
        
        repository.getPhotosBy(movieId: 525, completion: { result in
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
        let photos = [MovieImages(filePath: "/w2rWEjAMYErpNfoK2Z0GFh1LFhN.jpg")]
        
        mock.item = MovieImagesResponse(backdrops: photos)
        
        repository.getPhotosBy(movieId: 525, completion: { result in
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
