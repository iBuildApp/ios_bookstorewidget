//
//  BookDetailsViewController.swift
//  BookstoreModule
//
//  Created by Anton Boyarkin on 24/09/2019.
//

import UIKit
import IBACore
import IBACoreUI
import SafariServices

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
        
        mainView.onAuthor = {
            guard let data = self.data, let colorScheme = self.colorScheme else { return }
            let vc = AlertController(with: AuthorView(with: data, colorScheme: colorScheme), colorScheme: colorScheme)
            self.present(vc, animated: true, completion: nil)
        }
        
        mainView.onBuy = {
            if var link = self.data?.url.lowercased(), !link.isEmpty {
                if !link.contains("http://"), !link.contains("https://") {
                    link = "http://\(link)"
                }
                
                if let url = URL(string: link) {
                    let vc = SFSafariViewController(url: url)
                    vc.modalPresentationStyle = .overFullScreen
                    self.present(vc, animated: true, completion: nil)
                }
            }
        }
    }
}
