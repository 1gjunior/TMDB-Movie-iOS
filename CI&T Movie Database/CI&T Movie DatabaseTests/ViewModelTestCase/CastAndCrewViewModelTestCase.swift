//
//  CastAndCrewViewModelTestCase.swift
//  CI&T Movie DatabaseTests
//
//  Created by Gilberto Junior on 31/08/22.
//

@testable import CI_T_Movie_Database
import Combine
import XCTest

class CastAndCrewViewModelTestCase: XCTestCase {
    var viewModel: CastAndCrewViewModel!
    var mock = CastAndCrewRepositoryProtocolMock()
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() async throws {
        cancellables = []
        viewModel = CastAndCrewViewModel(castAndCrewRepository: mock)
    }
    
    override func tearDown() async throws {
        viewModel = nil
    }
    
    func test_error() {
        // MARK: - Given
        
        mock.error = NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "Error"])
        
        // MARK: Then
        
        viewModel.castAndCrewSubject.sink(receiveCompletion: { result in
            XCTAssertNotNil(result)
        }, receiveValue: { _ in
            XCTFail("Error test_error CastAndCrewViewModelTestCase")
        }).store(in: &cancellables)
        
        // MARK: When

        viewModel.getCastAndCrewBy(movieId: 182)
        XCTAssertEqual(mock.getCastAndCrewByCallCount, 1)
    }
    
    func test_success() {
        // MARK: - Given
        
        let data = [CastAndCrew(adult: false, gender: 2, id: 182, name: "Steve Carell", originalName: "Steve Carell", popularity: 18.255, profilePath: "/5XBzD5WuTyVQZeS4VI25z2moMeY.jpg", character: "Michael Scott", job: "")]
        
        mock.model = data
        
        // MARK: - Then

        viewModel.castAndCrewSubject.sink(receiveCompletion: { _ in
            XCTFail("Error test_success CastAndCrewViewModelTestCase")
        }, receiveValue: { result in
            XCTAssertEqual(result.count, 1)
        }).store(in: &cancellables)
        
        // MARK: - When

        viewModel.getCastAndCrewBy(movieId: 281)
        XCTAssertEqual(mock.getCastAndCrewByCallCount, 1)
    }
}
