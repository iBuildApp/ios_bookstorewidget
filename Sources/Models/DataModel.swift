//
//  DataModel.swift
//  BookstoreModule
//
//  Created by Anton Boyarkin on 15/08/2019.
//

import Foundation
import IBACore
import IBACoreUI

class DataModel: Codable {
    var colorScheme: ColorSchemeModel?
    var title: String?
    var menu: [MenuItemModel]?
    var content: [ContentItemModel]?
    
    enum CodingKeys: String, CodingKey {
        case colorScheme = "colorskin"
        case title
        case menu
        case content
    }
}

extension DataModel {
    func reset() {
        menu?.forEach({ item in
            item.isSelected = false
            item.items?.forEach({ item in
                item.isSelected = false
            })
        })
    }
}
