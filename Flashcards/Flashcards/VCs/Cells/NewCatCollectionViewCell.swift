//
//  NewCatCollectionViewCell.swift
//  Flashcards
//
//  Created by C4Q on 2/22/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class NewCatCollectionViewCell: UICollectionViewCell {
    
    lazy var newButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "icoAddDeck32x32"), for: .normal)
        button.tintColor = UIColor.blue
        button.backgroundColor = UIColor.white
        return button
    }()
    
    func configCell() {
        setupConstraints()
    }
    
    override func layoutSubviews() {
        newButton.layer.borderColor = UIColor.init(red: 103/255, green: 179/255, blue: 233/255, alpha: 1).cgColor
        newButton.layer.cornerRadius = newButton.bounds.width / 2
        newButton.layer.borderWidth = 2.5
        newButton.layer.masksToBounds = true
    }
    
    private func setupConstraints() {
        addSubview(newButton)
        newButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(snp.centerX)
            make.centerY.equalTo(snp.centerY)
            make.height.width.equalTo(snp.height)
        }
    }
}
