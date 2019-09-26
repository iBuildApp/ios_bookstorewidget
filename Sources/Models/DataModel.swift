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
    var menu: [MenuItemModel]?
    var content: [ContentItemModel]?
    
    enum CodingKeys: String, CodingKey {
        case colorScheme = "colorskin"
        case menu
        case content
    }
    
    var searchText: String = ""
}

extension DataModel {
    func reset() {
        searchText = ""
        menu?.forEach({ item in
            item.isSelected = false
            item.items?.forEach({ item in
                item.isSelected = false
            })
        })
    }
    
    func filtered() -> [ContentItemModel]? {
        var filtred: [ContentItemModel]? = self.content
        
        if let tags = menu?.filter({ item -> Bool in
            return item.isSelected == true
        }).compactMap({ item -> BookTags? in
            return BookTags(rawValue: item.tag.lowercased())
        }), tags.count > 0 {
            filtred = filtred?.filter({ item -> Bool in
                item.tags.contains { tag -> Bool in
                    return tags.contains(tag)
                }
            })
        }
        
        if !searchText.isEmpty {
            filtred = filtred?.filter({ item -> Bool in
                return (item.title.range(of: searchText, options: .caseInsensitive) != nil) || (item.description.range(of: searchText, options: .caseInsensitive) != nil)
            })
        }
        
        if let categories = genresItem?.items?.filter({ item -> Bool in
            return item.isSelected == true
        }).compactMap({ item -> String? in
            return item.name
        }), categories.count > 0 {
            filtred = filtred?.filter({ item -> Bool in
                return categories.contains(item.category ?? "")
            })
        }
        
        return filtred
    }
    
    var genresItem: MenuItemModel? {
        return menu?.first(where: { item -> Bool in
            return item.items != nil
        })
    }
}
