//
//  MediaRouter.swift
//  MyMediaFinder
//
//  Created by Diego on 12/11/19.
//  Copyright © 2019 Diego Sepúlveda. All rights reserved.
//

import UIKit
import Alertift

protocol MediaRouterProtocol {
    func showMediaDetail(media: Media, songs: [Media])
    func showErrorAlert(error: String)
}

class MediaRouter: MediaRouterProtocol {

    weak var view: MediaViewController?

    init(view: MediaViewController) {
        self.view = view
    }

    func showMediaDetail(media: Media, songs: [Media]) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailViewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailViewController.presenter.media = media
        detailViewController.presenter.songs = songs
        view?.navigationController?.pushViewController(detailViewController,
                                                               animated: true)
    }
    
    func showErrorAlert(error: String) {
        Alertift.alert(title: "Error", message: error)
        .action(.default("OK"))
        .show()
    }

}
