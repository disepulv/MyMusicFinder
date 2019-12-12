//
//  MediaViewControllerMock.swift
//  MyMediaFinderTests
//
//  Created by Diego on 12/12/19.
//  Copyright © 2019 Diego Sepúlveda. All rights reserved.
//

import Foundation
@testable import MyMediaFinder

class MediaViewControllerMock: MediaViewControllerProtocol {
    var setUpUICalled = false
    func setUpUI() {
        setUpUICalled = true
    }
}
