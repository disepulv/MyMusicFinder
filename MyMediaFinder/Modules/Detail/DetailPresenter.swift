//
//  MediaPresenter.swift
//  MyMediaFinder
//
//  Created by Diego on 12/11/19.
//  Copyright © 2019 Diego Sepúlveda. All rights reserved.
//

import Foundation

protocol DetailPresenterProtocol {
    var media: Media? { get set }
    var songs: [Media] { get set }
}

class DetailPresenter: DetailPresenterProtocol {
   
    var media: Media?
    var songs = [Media]()

    weak var view: DetailViewControllerProtocol?
    
    init(view: DetailViewControllerProtocol) {
        self.view = view
    }
    
}
