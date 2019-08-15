//
//  MainView.swift
//  BookstoreModule
//
//  Created by Anton Boyarkin on 15/08/2019.
//

import UIKit
import FlexLayout
import PinLayout
import IBACore
import IBACoreUI
import PKHUD

internal class MainView: UIView {
    private let contentView = UIScrollView()
    private let rootFlexContainer = UIView()
    
    private let model: DataModel
    private let colorScheme: ColorSchemeModel
    
    init(model: DataModel, colorScheme: ColorSchemeModel) {
        self.model = model
        self.colorScheme = colorScheme
        super.init(frame: .zero)
        
        backgroundColor = colorScheme.backgroundColor
        
        rootFlexContainer.flex.define { (flex) in
            
        }
        
        contentView.addSubview(rootFlexContainer)
        
        addSubview(contentView)
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
}
