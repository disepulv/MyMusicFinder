//
//  FinderViewController.swift
//  MyMediaFinder
//
//  Created by Diego on 12/11/19.
//  Copyright © 2019 Diego Sepúlveda. All rights reserved.
//

import UIKit

protocol FinderViewControllerProtocol: class {
    func setUpUI()
    func setTextFieldWithQuery(query: String)
    func searchButtonTapped(_ sender: Any)
}

class FinderViewController: UIViewController, FinderViewControllerProtocol, UITextFieldDelegate {

    @IBOutlet weak var queryTextField: UITextField!
    @IBOutlet weak var queryLabel: UILabel!
    @IBOutlet weak var searchButton: UIButton!
    
    lazy var presenter: FinderPresenterProtocol = {
        let router = FinderRouter(view: self) as FinderRouterProtocol
        return FinderPresenter(view: self, router: router)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        queryTextField.delegate = self
        setUpUI()
    }
    
    func setUpUI() {
        self.title = "Buscador"
        queryLabel.text = "Ingrese artista o canción"
        searchButton.setTitle("Buscar",for: .normal)
    }
    
    // MARK: - Navigation
    func setTextFieldWithQuery(query: String) {
        queryTextField.text = query
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        guard let query = queryTextField.text else  { return }
        presenter.handleSearchButtonTapped(query: query)
    }

}
