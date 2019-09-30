//
//  MainViewController.swift
//  BookstoreModule
//
//  Created by Anton Boyarkin on 15/08/2019.
//

import UIKit
import IBACore
import IBACoreUI

class MainViewController: BaseListViewController<BookCell> {
    // MARK: - Private properties
    /// Widget type indentifier
    private var type: String?
    
    /// Widger config data
    private var data: DataModel?
    
    private var colorScheme: ColorSchemeModel?
    
    // MARK: - Controller life cycle methods
    convenience init(type: String?, data: DataModel?) {
        let colorScheme = data?.colorScheme ?? AppManager.manager.appModel()?.design?.colorScheme
        self.init(with: colorScheme, data: data?.content)
        self.type = type
        self.data = data
        self.colorScheme = colorScheme
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.onItemSelect = { item in
            let vc = BookDetailsViewController(with: self.colorScheme, data: item)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: getCoreUIImage(with: "filters"), style: .plain, target: self, action: #selector(showFilter))
    }
    
    @objc
    func showFilter() {
        let filterVC = FilterViewController(data: data)
        filterVC.delegate = self
        let vc = UINavigationController(rootViewController: filterVC)
        
        if #available(iOS 13.0, *) {
            vc.modalPresentationStyle = .automatic
        } else {
            vc.modalPresentationStyle = .overFullScreen
        }
        
        self.present(vc, animated: true, completion: nil)
    }
}
