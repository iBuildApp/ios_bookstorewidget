//
//  DataModel.swift
//  BookstoreModule
//
//  Created by Anton Boyarkin on 15/08/2019.
//

import Foundation
import IBACore
import IBACoreUI

struct DataModel: Codable {
    var colorScheme: ColorSchemeModel?
    var title: String
    
    enum CodingKeys: String, CodingKey {
        case colorScheme = "colorskin"
        case title
    }
}
