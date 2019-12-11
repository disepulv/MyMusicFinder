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
        mockPresenter = nil
        fvc = nil
        window = nil
        super.tearDown()
    }

    // MARK: Test setup
    func setupFinderViewController()  {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        fvc = storyboard.instantiateViewController(withIdentifier: "FinderViewController") as! FinderViewController
        mockPresenter = FinderPresenterMock()
        fvc.presenter = self.mockPresenter
        window.rootViewController = fvc
        window.makeKeyAndVisible()
        _ = fvc.view
    }
 
    // MARK: Tests
    func testSetUpUI() {
        fvc.setUpUI()
        XCTAssertEqual(fvc.title, "Buscador")
        XCTAssertEqual(fvc.queryLabel.text, "Ingrese artista/canción")
        XCTAssertEqual(fvc.searchButton.titleLabel?.text, "Buscar")
    }

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
