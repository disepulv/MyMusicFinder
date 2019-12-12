//
//  MediaPresenterMock.swift
//  MyMediaFinderTests
//
//  Created by Diego on 12/12/19.
//  Copyright © 2019 Diego Sepúlveda. All rights reserved.
//

import Foundation
@testable import MyMediaFinder

class MediaPresenterMock: MediaPresenterProtocol {
    var getMediaCalled = false
    func getMedia() {
        getMediaCalled = true
    }
    
    var getMediaAsyncCalled = false
    func getMediaAsync(successCompletion: @escaping ([Media]?) -> Void, failureCompletion: @escaping (String) -> Void) {
        getMediaAsyncCalled = true
    }
    
    var showErrorAlertCalled = false
    func showErrorAlert(error: String) {
        showErrorAlertCalled = true
    }
    
    var handleDidSelectRowCalled = false
    func handleDidSelectRow(indexPathRow: Int) {
        handleDidSelectRowCalled = true
    }

    var query: String?

    var offset: Int?

    var mediaArray: [Media] = []
}
