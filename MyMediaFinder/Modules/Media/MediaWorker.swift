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
        
        if !MyMediaFinderConf.connectionActive {
            if let mediaResult = loadMediaByQuery(query: query.lowercased()) {
                completion(mediaResult)
            }
        }
        
        let escapedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        
        let urlString = "\(baseEndpoint)\(escapedQuery)"
        AF.request(urlString).response { response in
            guard let data = response.data else { return }
            do {
                let decoder = JSONDecoder()
                var mediaResult = try decoder.decode(MediaResult.self, from: data)
                mediaResult.query = query.lowercased()
                self.saveMedia(mediaResult: mediaResult)
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
    
    
    func loadMediaByQuery(query: String) -> MediaResult? {
        let defaults = UserDefaults.standard
        if let media = defaults.object(forKey: "media") as? Data {
            let decoder = JSONDecoder()
            if let loadedMedia = try? decoder.decode([MediaResult].self, from: media) {
                if let mediaByQuery = loadedMedia.first(where: {$0.query == query}) {
                   return mediaByQuery
                }
            }
        }

        return nil
    }
    
    func loadMedia() -> [MediaResult] {
        let defaults = UserDefaults.standard
        if let media = defaults.object(forKey: "media") as? Data {
            let decoder = JSONDecoder()
            if let loadedMedia = try? decoder.decode([MediaResult].self, from: media) {
                return loadedMedia
            }
        }

        return []
    }
    
    func saveMedia(mediaResult: MediaResult){
        var loadedMedia = loadMedia()
        
        if let index = loadedMedia.firstIndex(where: {$0.query == mediaResult.query}) {
            loadedMedia[index] = mediaResult
        } else {
            loadedMedia.insert(mediaResult, at: 0)
        }
        
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(loadedMedia) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "media")
        }
    }
}
