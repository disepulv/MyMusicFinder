//
//  MediaPresenter.swift
//  MyMediaFinder
//
//  Created by Diego on 12/11/19.
//  Copyright © 2019 Diego Sepúlveda. All rights reserved.
//

import Foundation

protocol MediaPresenterProtocol {
    func getMedia()
    func getMediaAsync(successCompletion: @escaping ([Media]?) -> Void,
                            failureCompletion: @escaping (String) -> Void)
    func showErrorAlert(error: String)
    func handleDidSelectRow(indexPathRow: Int)

    var query: String? { get set }
    var offset: Int? { get set }
    var mediaArray:[Media] { get set }
}

class MediaPresenter: MediaPresenterProtocol {

    
    var query: String?
    var offset: Int?
    var mediaArray = [Media]()

    weak var view: MediaViewControllerProtocol?
    var router: MediaRouterProtocol
    var worker: MediaWorkerProtocol
    
    init(view: MediaViewControllerProtocol,
         worker: MediaWorkerProtocol,
         router: MediaRouterProtocol) {
        self.view = view
        self.worker = worker
        self.router = router
    }
    
    func getMedia() {
        offset = 1
        worker.getMedia(query: query!, offset: offset!, completion: { (mediaResult) in
            self.mediaArray = mediaResult!.results
            print(mediaResult!.results)
        }) { (error) in
            self.showErrorAlert(error: "Error inesperado")
        }
        
    }
    
    func getMediaAsync(successCompletion: @escaping ([Media]?) -> Void, failureCompletion: @escaping (String) -> Void) {
        offset = 1
            worker.getMedia(query: query!, offset: offset!, completion: { (mediaResult) in
                self.mediaArray = mediaResult!.results
                successCompletion(self.mediaArray)
            }) { (error) in
                self.showErrorAlert(error: "Error inesperado")
                failureCompletion("Error inesperado")
            }
    }
    
    func handleDidSelectRow(indexPathRow: Int) {
        let selectedMedia = mediaArray[indexPathRow]
        
        let songs = worker.getSongs(selectedMedia: selectedMedia, allMedia: mediaArray)
        
        router.showMediaDetail(media: selectedMedia, songs: songs)
    }

    func showErrorAlert(error: String) {
        router.showErrorAlert(error: error)
    }
}
