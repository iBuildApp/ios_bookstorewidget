//
//  MainViewController.swift
//  BookstoreModule
//
//  Created by Anton Boyarkin on 15/08/2019.
//

import UIKit
import IBACore
import IBACoreUI

class MainViewController: BaseViewController {
    // MARK: - Private properties
    /// Widget type indentifier
    private var type: String?
    
    /// Widger config data
    private var data: DataModel?
    private var colorScheme: ColorSchemeModel?
    
    fileprivate var mainView: MainView {
        return self.view as! MainView
    }
    
    override public func loadView() {
        if let data = data, let colorScheme = colorScheme {
            view = MainView(model: data, colorScheme: colorScheme)
        }
    }
    
    // MARK: - Controller life cycle methods
    convenience init(type: String?, data: DataModel?) {
        let colorScheme = data?.colorScheme ?? AppManager.manager.appModel()?.design?.colorScheme
        self.init()
        self.type = type
        self.data = data
        self.colorScheme = colorScheme
        
        automaticallyAdjustsScrollViewInsets = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = data?.title
    }
}
