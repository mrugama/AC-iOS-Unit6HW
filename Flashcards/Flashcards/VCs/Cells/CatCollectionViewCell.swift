//
//  CatCollectionViewCell.swift
//  Flashcards
//
//  Created by C4Q on 2/22/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class CatCollectionViewCell: UICollectionViewCell {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        return label
    }()
    
    override func layoutSubviews() {
        self.backgroundColor = UIColor.init(red: 103/255, green: 179/255, blue: 233/255, alpha: 1)
    }
    
    func configCell(cat: Category) {
        setupConstraints()
        titleLabel.text = cat.name
        backgroundColor = .white
    }
    
    private func setupConstraints() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(snp.centerX)
            make.centerY.equalTo(snp.centerY)
        }
    }
    
}
