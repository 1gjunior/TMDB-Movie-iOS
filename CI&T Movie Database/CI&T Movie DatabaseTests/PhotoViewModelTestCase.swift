//
//  PhotoViewModelTestCase.swift
//  CI&T Movie DatabaseTests
//
//  Created by Gilberto Junior on 31/08/22.
//

@testable import CI_T_Movie_Database
import Combine
import XCTest

class PhotoViewModelTestCase: XCTestCase {
    var viewModel: PhotoViewModel!
    var mockPhotoRepository = PhotoRepositoryProtocolMock()
    var cancellables: Set<AnyCancellable>!

    override func setUp() async throws {
        cancellables = []
        viewModel = PhotoViewModel(photoRepository: mockPhotoRepository)
    }

    override func tearDown() async throws {
        viewModel = nil
    }

    func test_error() {
        // MARK: - Given

        mockPhotoRepository.error = NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "Error"])

        // MARK: - Then

        viewModel.photoSubject.sink(receiveCompletion: { result in
            XCTAssertNotNil(result)
        }, receiveValue: { _ in
            XCTFail("Error test_error PhotoViewModelTestCase")
        }).store(in: &cancellables)

        // MARK: - When

        viewModel.getPhotosBy(movieId: 819)
        XCTAssertEqual(mockPhotoRepository.getPhotosByCallCount, 1)
    }

    func test_success() {
        // MARK: - Given

        let data = [MovieImages(filePath: "/w2rWEjAMYErpNfoK2Z0GFh1LFhN.jpg")]
        mockPhotoRepository.data = data

        // MARK: - Then

        viewModel.photoSubject.sink(receiveCompletion: { _ in
            XCTFail("Error test_success PhotoViewModelTestCase")
        }, receiveValue: { result in
            XCTAssertEqual(result.count, 1)
        }).store(in: &cancellables)

        // MARK: - When

        viewModel.getPhotosBy(movieId: 819)
        XCTAssertEqual(mockPhotoRepository.getPhotosByCallCount, 1)
    }
}
