//
//  FinderRouter.swift
//  MyMediaFinder
//
//  Created by Diego on 12/11/19.
//  Copyright © 2019 Diego Sepúlveda. All rights reserved.
//

import UIKit
import Alertift
import AVFoundation

protocol FinderRouterProtocol {
    func showMedia(query: String)
    func showFormatQueryAlert()
}

class FinderRouter: FinderRouterProtocol {

    weak var view: FinderViewController?

    init(view: FinderViewController) {
        self.view = view
    }

    func showMedia(query: String) {

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mediaViewController = storyboard.instantiateViewController(withIdentifier: "MediaViewController") as! MediaViewController
        mediaViewController.presenter.query = query
        view?.navigationController?.pushViewController(mediaViewController,
                                                               animated: true)
    }
    
    func showFormatQueryAlert() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        Alertift.alert(title: "Atención", message: "Ingrese artista o canción (formato: letras o números, con minimo de 3 caracteres)")
                   .action(.default("OK"))
                   .show()
    }

}
