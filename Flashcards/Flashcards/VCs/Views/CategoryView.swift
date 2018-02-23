//
//  CategoryView.swift
//  Flashcards
//
//  Created by C4Q on 2/20/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class CategoryView: UIView {

    lazy var catLabel: UILabel = {
        let label = UILabel()
        label.text = "  Categories  "
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.textColor = .white
        label.backgroundColor = .black
        label.layer.cornerRadius = 10
        return label
    }()
    
    lazy var catCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        cv.register(NewCatCollectionViewCell.self, forCellWithReuseIdentifier: "CatCellNew")
        cv.register(CatCollectionViewCell.self, forCellWithReuseIdentifier: "CatCell")
        cv.backgroundColor = UIColor.black
        return cv
    }()
    
    lazy var deckLabel: UILabel = {
        let label = UILabel()
        label.text = "Decks"
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.textColor = UIColor.darkGray
        return label
    }()
    
    lazy var addDeck: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "icoAdd32x32"), for: .normal)
        return button
    }()
    
    lazy var deckTableView: UITableView = {
        let tv = UITableView()
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "DeckCell")
        return tv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        catLabel.setNeedsLayout()
    }
    
    private func commonInit() {
        addSubview(catLabel)
        catLabel.snp.makeConstraints { (make) in
            make.left.equalTo(snp.left)
            make.top.equalTo(snp.top).offset(32)
        }
        
        addSubview(catCollectionView)
        catCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(catLabel.snp.bottom).offset(-2)
            make.width.equalTo(snp.width)
            make.height.equalTo(snp.height).multipliedBy(0.15)
            make.centerX.equalTo(snp.centerX)
        }
        
        addSubview(deckLabel)
        deckLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(snp.centerX)
            make.top.equalTo(catCollectionView.snp.bottom).offset(32)
        }
        
        addSubview(addDeck)
        addDeck.snp.makeConstraints { (make) in
            make.centerY.equalTo(deckLabel.snp.centerY)
            make.right.equalTo(snp.right).offset(-32)
        }
        
        addSubview(deckTableView)
        deckTableView.snp.makeConstraints { (make) in
            make.top.equalTo(deckLabel.snp.bottom).offset(16)
            make.width.equalTo(snp.width)
            make.bottom.equalTo(snp.bottom)
            make.centerX.equalTo(snp.centerX)
        }
    }
}
