//
//  MediaViewControllerTest.swift
//  MyMediaFinderTests
//
//  Created by Diego on 12/11/19.
//  Copyright © 2019 Diego Sepúlveda. All rights reserved.
//

@testable import MyMediaFinder
import XCTest

class MediaViewControllerTests: XCTestCase
{
    var mvc: MediaViewController!
    var window: UIWindow!
    var mockPresenter: MediaPresenterMock!

    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupMediaViewController()
    }

    override func tearDown() {
        mockPresenter = nil
        mvc = nil
        window = nil
        super.tearDown()
    }

    // MARK: Test setup
    func setupMediaViewController()  {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        mvc = storyboard.instantiateViewController(withIdentifier: "MediaViewController") as! MediaViewController
        mockPresenter = MediaPresenterMock()
        mvc.presenter = self.mockPresenter
        window.rootViewController = mvc
        window.makeKeyAndVisible()
        _ = mvc.view
    }
 
    // MARK: Tests
    func testSetUpUI() {
        mvc.setUpUI()
        XCTAssertEqual(mvc.title, "Media")
    }
    
    func testMediaArrayEmpty() {
       XCTAssertEqual(mvc.tableView.numberOfRows(inSection: 0), 0)
    }
    
    func testMediaArrayNotEmpty() {
        mockPresenter.mediaArray = [Media(wrapperType: "test")]
        mvc.tableView.reloadData()
        XCTAssertEqual(mvc.tableView.numberOfRows(inSection: 0), 1)
    }
    
    func testDidSelect() {
        mockPresenter.mediaArray = [Media(wrapperType: "test")]
        mvc.tableView.reloadData()
        mvc.tableView(mvc.tableView, didSelectRowAt: IndexPath(row: 0, section: 1))
        XCTAssertTrue(mockPresenter.handleDidSelectRowCalled)
    }
}
