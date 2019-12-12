//
//  MediaWorker.swift
//  MyMediaFinder
//
//  Created by Diego on 12/11/19.
//  Copyright © 2019 Diego Sepúlveda. All rights reserved.
//

import Foundation
import Alamofire

protocol MediaWorkerProtocol {
    func getMedia(query: String, offset: Int, completion: @escaping (MediaResult?) -> Void, failure:((Error) -> Void)!)
    func getSongs(selectedMedia: Media, allMedia: [Media]) -> [Media]
}

class MediaWorker: MediaWorkerProtocol {

    var baseEndpoint: String

    init() {
        let path = Bundle.main.path(forResource: "Info", ofType:"plist")
        let dict = NSDictionary(contentsOfFile:path!)
        baseEndpoint = dict?.object(forKey: "URL_SERVICES") as! String
    }

    func getMedia(query: String, offset: Int, completion: @escaping (MediaResult?) -> Void, failure:((Error) -> Void)!) {
        let escapedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        
        let urlString = "\(baseEndpoint)\(escapedQuery))"
        AF.request(urlString).response { response in
            guard let data = response.data else { return }
            do {
                let decoder = JSONDecoder()
                let mediaResult = try decoder.decode(MediaResult.self, from: data)
                completion(mediaResult)
            } catch let error {
                failure(error)
            }
        }
    }
    
    func getSongs(selectedMedia: Media, allMedia: [Media]) -> [Media] {
        let songs = allMedia.filter( {$0.collectionId == selectedMedia.collectionId }).map({ return $0 })
        return songs
    }

}
