//
//  FinderViewControllerTests.swift
//  MyMediaFinder
//
//  Created by Diego on 12/11/19.
//  Copyright (c) 2019 Diego Sepúlveda. All rights reserved.
//

@testable import MyMediaFinder
import XCTest

class FinderViewControllerTests: XCTestCase
{
    var fvc: FinderViewController!
    var window: UIWindow!
    var mockPresenter: FinderPresenterMock!

    // MARK: Test lifecycle

    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupFinderViewController()
    }

    override func tearDown() {
        fvc = nil
        window = nil
        super.tearDown()
    }

    // MARK: Test setup

    func setupFinderViewController()  {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        fvc = storyboard.instantiateViewController(withIdentifier: "FinderViewController") as! FinderViewController
        window.rootViewController = fvc
        window.makeKeyAndVisible()
    }
 
    // MARK: Tests
    func testSetTextFieldWithQuery() {
        fvc.setTextFieldWithQuery(query: "Rolling Stones")
        XCTAssertEqual(fvc.queryTextField.text, "Rolling Stones")
    }
    
    func testSearchButtonTapped() {
        fvc.queryTextField.text = "50000"
        fvc.searchButtonTapped(UIButton())
        XCTAssertTrue(mockPresenter.handleSearchButtonTappedCalled)
    }
}
