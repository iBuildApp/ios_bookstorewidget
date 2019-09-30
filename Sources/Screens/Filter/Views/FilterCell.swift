//
//  FilterCell.swift
//  BookstoreModule
//
//  Created by Anton Boyarkin on 25/09/2019.
//

import UIKit
import IBACore
import IBACoreUI
import PinLayout
import FlexLayout
import Kingfisher

class FilterCell: UITableViewCell, BaseCellType {
    typealias ModelType = MenuItemModel
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    private let iconImageView = UIImageView()
    private let itemTitleLabel = UILabel()
    private let chechmarkImageView = UIImageView()
    
    var onAction: ((ModelType) -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        separatorInset = .zero
        
        itemTitleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        itemTitleLabel.lineBreakMode = .byTruncatingTail
        itemTitleLabel.numberOfLines = 0
        itemTitleLabel.textColor = .black
        
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.clipsToBounds = true
        
        chechmarkImageView.contentMode = .scaleAspectFit
        chechmarkImageView.clipsToBounds = true
        
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        contentView.flex.padding(10, 10, 0, 10).addItem().direction(.row).define { flex in
            flex.addItem(iconImageView).height(35).aspectRatio(1).shrink(1)
            flex.addItem(itemTitleLabel).marginHorizontal(10).grow(1)
            flex.addItem(chechmarkImageView).height(20).aspectRatio(1).shrink(1)
        }
        
        chechmarkImageView.image = getCoreUIImage(with: "bookstoreCheckedState")?.withRenderingMode(.alwaysTemplate)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: ModelType) {
        itemTitleLabel.text = model.name
        itemTitleLabel.flex.markDirty()
        
        if let url = model.iconUrl {
            KingfisherManager.shared.retrieveImage(with: url) { result in
                DispatchQueue.main.async {
                    self.iconImageView.image = try? result.get().image.withRenderingMode(.alwaysTemplate)
                }
            }
        }
        
        chechmarkImageView.isHidden = !model.isSelected
        
        flex.layout()
    }
    
    func setColorScheme(_ colorScheme: ColorSchemeModel) {
        itemTitleLabel.textColor = colorScheme.textColor
        iconImageView.tintColor = colorScheme.primaryColor
        chechmarkImageView.tintColor = colorScheme.primaryColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    fileprivate func layout() {
        contentView.flex.layout(mode: .adjustHeight)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        contentView.pin.width(size.width)
        layout()
        return contentView.frame.size
    }
}
