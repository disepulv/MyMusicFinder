//
//  DetailPresenterMock.swift
//  MyMediaFinderTests
//
//  Created by Diego on 12/12/19.
//  Copyright © 2019 Diego Sepúlveda. All rights reserved.
//

import Foundation
@testable import MyMediaFinder

class DetailPresenterMock: DetailPresenterProtocol {
    var media: Media?

    var songs: [Media] = [Media(artworkUrl100: "test")]
    
}
