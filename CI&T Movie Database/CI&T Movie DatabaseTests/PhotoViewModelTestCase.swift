//
//  PhotoViewModelTestCase.swift
//  CI&T Movie DatabaseTests
//
//  Created by Gilberto Junior on 31/08/22.
//

import XCTest
@testable import CI_T_Movie_Database

class PhotoViewModelTestCase: XCTestCase {

    var viewModel = PhotoViewModel()
    var mockPhotoRepository = MockPhotoRepository()
    
    override func setUp() {
        viewModel = .init(photoRepository: mockPhotoRepository)
    }
}
