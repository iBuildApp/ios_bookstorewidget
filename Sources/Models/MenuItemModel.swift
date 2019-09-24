//
//  MenuItemModel.swift
//  BookstoreModule
//
//  Created by Anton Boyarkin on 24/09/2019.
//

import Foundation
import IBACore
import IBACoreUI

struct MenuItemModel: Codable, CellModelType {
    var name: String
    var tag: String
    var icon: String
    var items: [String]?
}
