//
//  GenreSelectViewController.swift
//  BookstoreModule
//
//  Created by Anton Boyarkin on 25/09/2019.
//

import UIKit
import IBACore
import IBACoreUI

class GenreSelectViewController: BaseListViewController<GenreCell> {
    // MARK: - Private properties
    private var data: MenuItemModel?
    private var colorScheme: ColorSchemeModel?
    
    // MARK: - Controller life cycle methods
    convenience init(data: MenuItemModel?, colorScheme: ColorSchemeModel?) {
        self.init(with: colorScheme, data: data?.items)
        self.data = data
        self.colorScheme = colorScheme
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = data?.name
        
        self.onItemSelect = { item in
            print(item.name)
            item.isSelected = !item.isSelected
            self.tableView.reloadData()
        }
    }
}
