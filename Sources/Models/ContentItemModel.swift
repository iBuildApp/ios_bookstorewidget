//
//  ContentItemModel.swift
//  BookstoreModule
//
//  Created by Anton Boyarkin on 24/09/2019.
//

import Foundation
import IBACore
import IBACoreUI

struct ContentItemModel: Codable, CellModelType {
    let id: String
    let title: String
    let description: String
    let author: String
    let authorDescription: String
    let thumbnailAuthor: String
    let thumbnail: String
    let url: String
    let price: String
    let category: String?
    let recommended: UInt8
    let releases: UInt8
    let bestsellers: UInt8
}

extension ContentItemModel {
    var thumbnailAuthorUrl: URL? {
        if !thumbnailAuthor.isEmpty, (thumbnailAuthor.contains(".jpg") || thumbnailAuthor.contains(".jpeg") || thumbnailAuthor.contains(".png")), let url = URL(string: thumbnailAuthor) {
            return url
        }
        return nil
    }
    
    var thumbnailUrl: URL? {
        if !thumbnail.isEmpty, (thumbnail.contains(".jpg") || thumbnail.contains(".jpeg") || thumbnail.contains(".png")), let url = URL(string: thumbnail) {
            return url
        }
        return nil
    }
}
