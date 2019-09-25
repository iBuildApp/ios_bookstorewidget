//
//  AuthorView.swift
//  BookstoreModule
//
//  Created by Anton Boyarkin on 25/09/2019.
//

import UIKit
import FlexLayout
import PinLayout
import IBACore
import IBACoreUI

class AuthorView: UIView {
    
    private let coverImageView = UIImageView()
    private let authorLabel = UILabel()
    private let bioLabel = UILabel()
        
    init(with data: ContentItemModel, colorScheme: ColorSchemeModel) {
        super.init(frame: .zero)
        
        authorLabel.font = UIFont.boldSystemFont(ofSize: 18)
        authorLabel.lineBreakMode = .byTruncatingTail
        authorLabel.numberOfLines = 0
        authorLabel.textColor = colorScheme.textColor
        
        bioLabel.font = UIFont.systemFont(ofSize: 16)
        bioLabel.lineBreakMode = .byTruncatingTail
        bioLabel.numberOfLines = 0
        bioLabel.textColor = colorScheme.secondaryColor
        
        coverImageView.contentMode = .scaleAspectFill
        coverImageView.clipsToBounds = true
        
        flex.direction(.row).define { flex in
            flex.addItem(coverImageView).height(100).aspectRatio(100.0/150.0).shrink(1)
            flex.addItem().paddingLeft(10).direction(.column).define { flex in
                flex.addItem(authorLabel)
                flex.addItem(bioLabel).marginTop(8)
            }
        }
        
        authorLabel.text = data.author
        bioLabel.text = data.authorDescription
        
        if let url = data.thumbnailAuthorUrl {
            coverImageView.kf.setImage(with: url, placeholder: getCoreUIImage(with: "placeholder_image"))
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
