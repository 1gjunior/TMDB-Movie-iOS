//
//  CIT_Movie_DatabaseUITests.swift
//  CIT Movie DatabaseUITests
//
//  Created by Gilberto Junior on 05/09/22.
//

import XCTest

class CIT_Movie_DatabaseUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        app = .init()
        app.launch()

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    func test_home_to_details_page() throws {
        // UI tests must launch the application that they test.
        let nowPlayingButton = app.buttons["Now Playing"]
        let comingSoonButton = app.buttons["Coming Soon"]
        
        XCTAssert(nowPlayingButton.exists)
        XCTAssert(comingSoonButton.exists)
        
        comingSoonButton.tap()
        let comingSoonCollectionView = app.collectionViews
        
        XCTAssertEqual(comingSoonCollectionView.count, 1)
        
        nowPlayingButton.tap()
        let nowPlayingCollectionView = app.collectionViews
        
        XCTAssertEqual(nowPlayingCollectionView.count, 1)
        
        let movie = app.collectionViews.cells.otherElements.firstMatch
        
        XCTAssert(movie.exists)
        
        movie.tap()
        let synopsisTitle = app.staticTexts["Synopsis"]
        let castAndCrewTitle = app.staticTexts["Cast & Crew"]
        let photosTitle = app.staticTexts["Photos"]
        
        XCTAssert(synopsisTitle.exists)
        XCTAssert(castAndCrewTitle.exists)
        XCTAssert(photosTitle.exists)
    }
}
