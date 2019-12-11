//
//  FinderPresenterMock.swift
//  MyMediaFinderTests
//
//  Created by Diego on 12/11/19.
//  Copyright © 2019 Diego Sepúlveda. All rights reserved.
//

import Foundation
@testable import MyMediaFinder

class FinderPresenterMock: FinderPresenterProtocol {
    var handleSearchButtonTappedCalled = false
    func handleSearchButtonTapped(query: String) {
        handleSearchButtonTappedCalled = true
    }
}
