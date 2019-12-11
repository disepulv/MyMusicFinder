//
//  FinderRouter.swift
//  MyMediaFinder
//
//  Created by Diego on 12/11/19.
//  Copyright © 2019 Diego Sepúlveda. All rights reserved.
//

import UIKit
import Alertift

protocol FinderRouterProtocol {
    func goMedia(query: String)
    func showFormatQueryAlert()
}

class FinderRouter: FinderRouterProtocol {

    weak var view: FinderViewController?

    init(view: FinderViewController) {
        self.view = view
    }

    func goMedia(query: String) {
    }
    
    func showFormatQueryAlert() {
        Alertift.alert(title: "Atención", message: "Ingrese artista o canción! (formato: letras o números, con minimo de 3 caracteres)")
                   .action(.default("OK"))
                   .show()
    }

}
