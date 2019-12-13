//
//  MediaModel.swift
//  MyMediaFinder
//
//  Created by Diego on 12/11/19.
//  Copyright © 2019 Diego Sepúlveda. All rights reserved.
//

import Foundation

struct MediaResult:Codable {
    var query:String?
    var resultCount:Int?
    var results : [Media]
}

struct Media:Codable {
    var wrapperType:String?
    var kind:String?
    var artistId:Int?
    var collectionId:Int?
    var trackId:Int?
    var artistName:String?
    var collectionName:String?
    var trackName:String?
    var collectionCensoredName:String?
    var trackCensoredName:String?
    var artistViewUrl:String?
    var collectionViewUrl:String?
    var trackViewUrl:String?
    var previewUrl:String?
    var artworkUrl60:String?
    var artworkUrl100:String?
    var collectionPrice:Float?
    var trackPrice:Float?
    var collectionExplicitness:String?
    var trackExplicitness:String?
    var discCount:Int?
    var discNumber:Int?
    var trackCount:Int?
    var trackNumber:Int?
    var trackTimeMillis:Int?
    var country:String?
    var currency:String?
    var primaryGenreName:String?
}




