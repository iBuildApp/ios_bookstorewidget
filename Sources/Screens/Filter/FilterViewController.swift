//
//  FilterViewController.swift
//  BookstoreModule
//
//  Created by Anton Boyarkin on 25/09/2019.
//

import UIKit
import IBACore
import IBACoreUI

class FilterViewController: BaseListViewController<FilterCell> {
    // MARK: - Private properties
    private var data: DataModel?
    private var colorScheme: ColorSchemeModel?
    private var searchView: SearchView?
    private var resetButton: ButtonView?
    
    public weak var delegate: MainViewController?
    
    // MARK: - Controller life cycle methods
    convenience init(data: DataModel?) {
        let colorScheme = data?.colorScheme ?? AppManager.manager.appModel()?.design?.colorScheme
        let searchView = SearchView(colorScheme: colorScheme)
        let resetButton = ButtonView(with: "Reset filters", icon: getCoreUIImage(with: "filtersReset"), colorScheme: colorScheme)
        
        self.init(with: colorScheme, data: data?.menu, headerView: searchView, footerView: resetButton)
        self.data = data
        self.colorScheme = colorScheme
        self.searchView = searchView
        self.resetButton = resetButton
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchView?.searchBar.text = data?.searchText
        
        self.onItemSelect = { item in
            if item.items != nil {
                let vc = GenreSelectViewController(data: item, colorScheme: self.colorScheme)
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                item.isSelected = !item.isSelected
                self.tableView.reloadData()
            }
        }
        
        self.resetButton?.onAction = {
            self.searchView?.searchBar.text = ""
            self.data?.reset()
            self.tableView.reloadData()
        }
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
    }
            
    @objc
    func done() {
        self.data?.searchText = searchView?.searchBar.text ?? ""
        delegate?.configure(data: self.data?.filtered() ?? [ContentItemModel]())
        
        self.dismiss(animated: true)
    }
}

class SearchView: UIView {
    let searchBar = UISearchBar()
    
    init(colorScheme: ColorSchemeModel?) {
        super.init(frame: .zero)
        
        searchBar.backgroundColor = colorScheme?.backgroundColor ?? .clear
        searchBar.backgroundImage = UIImage()
        
        searchBar.placeholder = "Search"
        
        flex.direction(.row).define { flex in
            flex.addItem(searchBar).grow(1)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    fileprivate func layout() {
        flex.layout(mode: .adjustHeight)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        pin.width(size.width)
        layout()
        return frame.size
    }
}

class ButtonView: UIView {
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    
    var onAction: (()->Void)?
        
    init(with name: String, icon: UIImage?, colorScheme: ColorSchemeModel?) {
        super.init(frame: .zero)
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.numberOfLines = 0
        titleLabel.textColor = colorScheme?.textColor ?? .black
        
        iconImageView.tintColor = colorScheme?.primaryColor ?? .black
        
        iconImageView.contentMode = .scaleAspectFill
        iconImageView.clipsToBounds = true
        
        flex.direction(.row).padding(10).define { flex in
            if icon != nil {
                flex.addItem(iconImageView).height(35).aspectRatio(1).shrink(1)
            }
            flex.addItem(titleLabel).marginLeft(10).grow(1)
        }
        
        titleLabel.text = name
        iconImageView.image = icon?.withRenderingMode(.alwaysTemplate)
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTap)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    fileprivate func layout() {
        flex.layout(mode: .adjustHeight)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        pin.width(size.width)
        layout()
        return frame.size
    }
    
    @objc
    func onTap() {
        onAction?()
    }
}
