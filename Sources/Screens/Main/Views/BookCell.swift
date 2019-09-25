//
//  BookCell.swift
//  BookstoreModule
//
//  Created by Anton Boyarkin on 24/09/2019.
//

import UIKit
import IBACore
import IBACoreUI
import PinLayout
import FlexLayout

class BookCell: UITableViewCell, BaseCellType {
    typealias ModelType = ContentItemModel
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    private let coverImageView = UIImageView()
    private let newsTitleLabel = UILabel()
    private let authorLabel = UILabel()
    
    var onAction: ((ModelType) -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        separatorInset = .zero
        
        newsTitleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        newsTitleLabel.lineBreakMode = .byTruncatingTail
        newsTitleLabel.numberOfLines = 0
        newsTitleLabel.textColor = .black
        
        authorLabel.font = UIFont.systemFont(ofSize: 16)
        authorLabel.lineBreakMode = .byTruncatingTail
        authorLabel.numberOfLines = 0
        authorLabel.textColor = UIColor.black.withAlphaComponent(0.5)
        
        coverImageView.contentMode = .scaleAspectFill
        coverImageView.clipsToBounds = true
        
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        contentView.flex.padding(10, 10, 0, 10).addItem().direction(.row).define { flex in
            flex.addItem(coverImageView).height(100).aspectRatio(100.0/150.0).shrink(1)
            flex.addItem().paddingLeft(10).direction(.column).define { flex in
                flex.addItem(newsTitleLabel).marginTop(8)
                flex.addItem(authorLabel).marginTop(8)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: ModelType) {
        newsTitleLabel.text = model.title
        newsTitleLabel.flex.markDirty()
        
        authorLabel.text = model.author
        authorLabel.flex.markDirty()
        
        if let url = model.thumbnailUrl {
            coverImageView.kf.setImage(with: url, placeholder: getCoreUIImage(with: "placeholder_image"))
        }
        flex.layout()
    }
    
    func setColorScheme(_ colorScheme: ColorSchemeModel) {
        newsTitleLabel.textColor = colorScheme.textColor
        authorLabel.textColor = colorScheme.secondaryColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    fileprivate func layout() {
        contentView.flex.layout(mode: .adjustHeight)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        // 1) Set the contentView's width to the specified size parameter
        contentView.pin.width(size.width)
        
        // 2) Layout contentView flex container
        layout()
        
        // Return the flex container new size
        return contentView.frame.size
    }
}
