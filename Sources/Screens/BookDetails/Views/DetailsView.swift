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
import PKHUD

public class DetailsView: UIView {
    private let contentView = UIScrollView()
    private let rootFlexContainer = UIView()
    
    private let model: ContentItemModel
    private let colorScheme: ColorSchemeModel
    
    init(model: ContentItemModel, colorScheme: ColorSchemeModel) {
        self.model = model
        self.colorScheme = colorScheme
        super.init(frame: .zero)
        
        backgroundColor = colorScheme.backgroundColor
        
        
        rootFlexContainer.flex.define { (flex) in
            ///
        }
        
        contentView.addSubview(rootFlexContainer)
        
        addSubview(contentView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        // 1) Layout the contentView & rootFlexContainer using PinLayout
        contentView.pin.all(pin.safeArea)
        rootFlexContainer.pin.top().left().right()
        
        // 2) Let the flexbox container layout itself and adjust the height
        rootFlexContainer.flex.layout(mode: .adjustHeight)
        
        // 3) Adjust the scrollview contentSize
        contentView.contentSize = rootFlexContainer.frame.size
    }
}
