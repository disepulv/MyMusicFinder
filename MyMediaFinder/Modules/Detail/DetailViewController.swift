//
//  DetailViewController.swift
//  MyMediaFinder
//
//  Created by Diego on 12/11/19.
//  Copyright © 2019 Diego Sepúlveda. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import JQProgressHUD

protocol DetailViewControllerProtocol: class {
    func setUpUI()
}

class DetailViewController: UITableViewController, DetailViewControllerProtocol {

    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var collectionNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    
    var player: AVPlayer?
    
    lazy var presenter: DetailPresenterProtocol = {
        return DetailPresenter(view: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    func setUpUI() {
        self.tableView.tableFooterView = UIView(frame:CGRect.zero)
        self.title = presenter.media?.artistName
        collectionNameLabel.text = presenter.media?.collectionName
        artistNameLabel.text = presenter.media?.artistName
        if presenter.media != nil {
            let url:URL = URL(string: presenter.media!.artworkUrl100!)!
            coverImageView.load(url: url)
        }
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return presenter.songs.count
    }

    override func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int {
        if indexPath.section == 0 {
            return super.tableView(tableView, indentationLevelForRowAt: indexPath)
        }

        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            return super.tableView(tableView, cellForRowAt: indexPath)
        } else {
            var cell : UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier")
            if(cell == nil)
            {
                cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "reuseIdentifier")
            }
            
            cell!.textLabel!.text = presenter.songs[indexPath.row].trackName
            cell!.textLabel!.numberOfLines = 0
            cell!.textLabel!.lineBreakMode = NSLineBreakMode.byWordWrapping
            cell!.textLabel!.textAlignment = NSTextAlignment.left
            cell!.imageView?.image = UIImage(systemName: "play")

            return cell!
        }
    }
    
    
      override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        player?.pause()
        
        if indexPath.section != 1 {
            return
        }
            
        let media = presenter.songs[indexPath.row]
        let preview = media.previewUrl!
        let url = URL(string: preview)
        
         do {
            player = AVPlayer(url: url!)
            player?.volume = 1.0
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            
            self.present(playerViewController, animated: true) {
                playerViewController.player!.play()
            }
            
        } catch {
            JQProgressHUDTool.jq_showToastHUD( msg: "Error al cargar archivo!")
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if indexPath.section == 0 {
            return super.tableView(tableView, heightForRowAt: indexPath)
        }
        return 44.0
    }

}
