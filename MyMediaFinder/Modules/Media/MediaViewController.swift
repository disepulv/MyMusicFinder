//
//  MediaTableViewController.swift
//  MyMediaFinder
//
//  Created by Diego on 12/11/19.
//  Copyright © 2019 Diego Sepúlveda. All rights reserved.
//

import UIKit
import JQProgressHUD

protocol MediaViewControllerProtocol: class {
    func setUpUI()
}

class MediaViewController: UITableViewController, MediaViewControllerProtocol {

    lazy var presenter: MediaPresenterProtocol = {
        let worker = MediaWorker()
        let router = MediaRouter(view: self) as MediaRouterProtocol
        return MediaPresenter(view: self, worker: worker, router: router)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    func setUpUI() {
        self.title = "Media"
        JQProgressHUDTool.jq_showToastHUD( msg: "Buscando...")
        
        presenter.getMediaAsync(successCompletion: { [weak self] (_) in
            self?.tableView.reloadData()
            JQProgressHUDTool.jq_hideHUD()
        }) { (String) in
            JQProgressHUDTool.jq_hideHUD()
        }
        self.tableView.reloadData()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.mediaArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var  cell:MediaTableViewCell! = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier") as? MediaTableViewCell

        if (cell == nil)
        {
            let nib:Array = Bundle.main.loadNibNamed("MediaTableViewCell", owner: self, options: nil)!
            cell = nib[0] as? MediaTableViewCell
        }
        
        let media = presenter.mediaArray[indexPath.row]
        cell.artistNameLabel.text = media.artistName
        cell.collectionNameLabel.text = media.collectionName
        cell.primaryGenreNameLabel.text = media.primaryGenreName
        cell.trackNameLabel.text = media.trackName

//        let localUrlString = paymentMethod.secureThumbnail
//        presenter.downloadImage(urlString: localUrlString) { (data) in
//            cell.paymentImageView.image = UIImage(data: data)
//        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 100.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.handleDidSelectRow(indexPathRow: indexPath.row)
        
    }

}
