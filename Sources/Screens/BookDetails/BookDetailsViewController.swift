//
//  BookDetailsViewController.swift
//  BookstoreModule
//
//  Created by Anton Boyarkin on 24/09/2019.
//

import UIKit
import IBACore
import IBACoreUI

class BookDetailsViewController: BaseViewController {
    private var data: ContentItemModel?
    private var colorScheme: ColorSchemeModel?
    
    // MARK: - Controller life cycle methods
    convenience init(with colorScheme: ColorSchemeModel?, data: ContentItemModel?) {
        self.init()
        self.data = data
        self.colorScheme = colorScheme
    }
    
    fileprivate var mainView: DetailsView {
        return self.view as! DetailsView
    }
    
    override public func loadView() {
        if let data = data, let colorScheme = colorScheme {
            view = DetailsView(model: data, colorScheme: colorScheme)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = data?.title
    }
}
