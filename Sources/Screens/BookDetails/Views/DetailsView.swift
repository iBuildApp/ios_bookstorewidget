//
//  DetailsView.swift
//  BookstoreModule
//
//  Created by Anton Boyarkin on 24/09/2019.
//

import UIKit
import FlexLayout
import PinLayout
import IBACore
import IBACoreUI

public class DetailsView: UIView {
    private let contentView = UIScrollView()
    private let rootFlexContainer = UIView()
    
    private let coverImageView = UIImageView()
    private let newsTitleLabel = UILabel()
    private let authorLabel = UILabel()
    private let categoryLabel = UILabel()
    private let categoryNameLabel = UILabel()
    private let priceLabel = UILabel()
    private let buyButton = UIButton(type: .custom)
    private let descriptionTitleLabel = UILabel()
    private let descriptionTextView = GrowingTextView()
    
    private let model: ContentItemModel
    private let colorScheme: ColorSchemeModel
    
    var onAuthor: (() -> Void)?
    var onBuy: (() -> Void)?
    
    init(model: ContentItemModel, colorScheme: ColorSchemeModel) {
        self.model = model
        self.colorScheme = colorScheme
        super.init(frame: .zero)
        
        backgroundColor = colorScheme.backgroundColor
        
        coverImageView.contentMode = .scaleAspectFill
        coverImageView.clipsToBounds = true
        
        newsTitleLabel.font = .boldSystemFont(ofSize: 20)
        newsTitleLabel.lineBreakMode = .byTruncatingTail
        newsTitleLabel.numberOfLines = 0
        newsTitleLabel.textColor = colorScheme.textColor
        
        authorLabel.font = .systemFont(ofSize: 18)
        authorLabel.lineBreakMode = .byTruncatingTail
        authorLabel.numberOfLines = 0
        authorLabel.textColor = colorScheme.textColor
        
        categoryLabel.font = .systemFont(ofSize: 18)
        categoryLabel.lineBreakMode = .byTruncatingTail
        categoryLabel.numberOfLines = 0
        categoryLabel.textColor = colorScheme.secondaryColor
        
        categoryNameLabel.font = .systemFont(ofSize: 18)
        categoryNameLabel.lineBreakMode = .byTruncatingTail
        categoryNameLabel.numberOfLines = 0
        categoryNameLabel.textColor = colorScheme.textColor
        
        priceLabel.font = .boldSystemFont(ofSize: 22)
        priceLabel.lineBreakMode = .byTruncatingTail
        priceLabel.numberOfLines = 0
        priceLabel.textColor = colorScheme.accentColor
        
        descriptionTitleLabel.font = .boldSystemFont(ofSize: 18)
        descriptionTitleLabel.lineBreakMode = .byTruncatingTail
        descriptionTitleLabel.numberOfLines = 0
        descriptionTitleLabel.textColor = colorScheme.textColor
        
        descriptionTextView.font = .systemFont(ofSize: 18)
        descriptionTextView.textColor = colorScheme.textColor
        descriptionTextView.backgroundColor = .clear
        descriptionTextView.textContainerInset = .zero
        descriptionTextView.isUserInteractionEnabled = false
        
        buyButton.setTitleColor(colorScheme.backgroundColor, for: .normal)
        buyButton.backgroundColor = colorScheme.accentColor
        buyButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        buyButton.contentEdgeInsets = .init(top: 5, left: 15, bottom: 5, right: 15)
        buyButton.layer.cornerRadius = 5
        
        rootFlexContainer.flex.padding(10).define { (flex) in
            flex.addItem().direction(.row).define { flex in
                flex.addItem(coverImageView).height(150).aspectRatio(100.0/150.0).shrink(1)
                flex.addItem().marginLeft(10).direction(.column).justifyContent(.spaceBetween).grow(1).define { flex in
                    flex.addItem(newsTitleLabel)
                    flex.addItem(authorLabel)
                    flex.addItem().direction(.row).define { flex in
                        flex.addItem(categoryLabel).marginRight(8)
                        flex.addItem(categoryNameLabel)
                    }
                    flex.addItem().direction(.row).justifyContent(.spaceBetween).define { flex in
                        flex.addItem(priceLabel)
                        flex.addItem(buyButton)
                    }
                }
            }
            flex.addItem(descriptionTitleLabel).marginTop(10)
            flex.addItem(descriptionTextView).marginTop(10)
        }
        
        contentView.addSubview(rootFlexContainer)
        
        addSubview(contentView)
        
        newsTitleLabel.text = model.title
        
        let attributeString = NSMutableAttributedString(string: model.author)
        attributeString.addAttribute(.underlineStyle, value: 1, range: NSRange(location: 0, length: attributeString.length))
        authorLabel.attributedText = attributeString
        
        if let url = model.thumbnailUrl {
            coverImageView.kf.setImage(with: url, placeholder: getCoreUIImage(with: "placeholder_image"))
        }
        
        categoryLabel.text = "Category:"
        categoryNameLabel.text = model.category
        
        if !model.price.isEmpty {
            priceLabel.text = "$ \(model.price)"
        }
        
        if !model.url.isEmpty {
            buyButton.setTitle("Buy", for: .normal)
            buyButton.addTarget(self, action: #selector(buy), for: .touchUpInside)
        } else {
            buyButton.isHidden = true
        }
        
        descriptionTitleLabel.text = "Description:"
        descriptionTextView.text = model.description
        
        authorLabel.isUserInteractionEnabled = true
        authorLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(author)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.pin.all(pin.safeArea)
        
        rootFlexContainer.pin.top().left().right()
        rootFlexContainer.flex.layout(mode: .adjustHeight)
        
        contentView.contentSize = rootFlexContainer.frame.size
    }
    
    @objc
    func author() {
        onAuthor?()
    }
    
    @objc
    func buy() {
        onBuy?()
    }
}
