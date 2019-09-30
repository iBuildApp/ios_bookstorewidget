//
//  MenuItemModel.swift
//  BookstoreModule
//
//  Created by Anton Boyarkin on 24/09/2019.
//

import Foundation
import IBACore
import IBACoreUI

class GenreItemModel: Codable, CellModelType {
    var name: String
    var isSelected: Bool = false
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.name = try container.decode(String.self)
    }
}

class MenuItemModel: Codable, CellModelType {
    enum CodingKeys: String, CodingKey {
        case name
        case tag
        case icon
        case items
    }
    
    var name: String
    var tag: String
    var icon: String
    var items: [GenreItemModel]?
    
    var isSelected: Bool = false
}

extension MenuItemModel {
    var iconUrl: URL? {
        if !icon.isEmpty, (icon.contains(".jpg") || icon.contains(".jpeg") || icon.contains(".png")), let url = URL(string: icon) {
            return url
        }
        return nil
    }
}
