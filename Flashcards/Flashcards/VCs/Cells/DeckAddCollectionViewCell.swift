//
//  DeckAddCollectionViewCell.swift
//  Flashcards
//
//  Created by C4Q on 2/16/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class DeckAddCollectionViewCell: UICollectionViewCell {
    
    lazy var addDeckButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "icoAdd64x64"), for: UIControlState.normal)
        button.backgroundColor = UIColor.red
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureConstraints() {
        addDeckButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(snp.centerX)
            make.centerY.equalTo(snp.centerY)
            make.width.height.equalTo(128)
        }
    }
}
