//
//  DetailViewControllerTests.swift
//  MyMediaFinderTests
//
//  Created by Diego on 12/12/19.
//  Copyright © 2019 Diego Sepúlveda. All rights reserved.
//

import XCTest
@testable import MyMediaFinder

class DetailViewControllerTests: XCTestCase {

    var dvc: DetailViewController!
    var window: UIWindow!
    var mockPresenter: DetailPresenterMock!

    // MARK: Test lifecycle
    override func setUp() {
       super.setUp()
       window = UIWindow()
       setupMediaViewController()
    }

    override func tearDown() {
       mockPresenter = nil
       dvc = nil
       window = nil
       super.tearDown()
    }

    // MARK: Test setup
    func setupMediaViewController()  {
       let bundle = Bundle.main
       let storyboard = UIStoryboard(name: "Main", bundle: bundle)
       dvc = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
       mockPresenter = DetailPresenterMock()
       dvc.presenter = self.mockPresenter
       window.rootViewController = dvc
       window.makeKeyAndVisible()
       _ = dvc.view
    }

    // MARK: Tests
    func testSetUpUI() {
       dvc.setUpUI()    }

    func testSongArrayNotEmpty() {
       dvc.tableView.reloadData()
       XCTAssertEqual(dvc.tableView.numberOfRows(inSection: 0), 1)
    }

}
