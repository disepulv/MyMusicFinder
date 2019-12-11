//
//  FinderPresenter.swift
//  MyMediaFinder
//
//  Created by Diego on 12/11/19.
//  Copyright © 2019 Diego Sepúlveda. All rights reserved.
//

import Foundation

protocol FinderPresenterProtocol {
    func handleSearchButtonTapped(query: String)
}

class FinderPresenter: FinderPresenterProtocol {
    var query: String?

    weak var view: FinderViewControllerProtocol?
    var router: FinderRouterProtocol

    init(view: FinderViewControllerProtocol, router: FinderRouterProtocol) {
        self.view = view
        self.router = router
    }

    func handleSearchButtonTapped(query: String) {
        if query.isValidQuery() {
            router.goMedia(query: query)
        } else {
            router.showFormatQueryAlert()
        }
        
    }
}
