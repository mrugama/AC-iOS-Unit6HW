//
//  Card.swift
//  Flashcards
//
//  Created by C4Q on 2/15/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class AddDeckView: UIView {
    
    var frontCard = NewCardView()
    var backCard = NewCardView()
    
    private var sidePosition = NSLayoutConstraint()
    
    lazy var cardNumLabel: UILabel = {
        let label = UILabel()
        label.text = "Card: 1"
        label.textColor = UIColor.init(red: 103/255, green: 179/255, blue: 233/255, alpha: 1)
        label.tintColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 30)
        return label
    }()
    
    lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "icoTrash32x32"), for: UIControlState.normal)
        return button
    }()
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewConst()
        setupView()
        frontCard.saveButton.isHidden = true
        backCard.saveButton.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        scrollView.setNeedsLayout()
        frontCard.setNeedsLayout()
        backCard.setNeedsLayout()
    }
    
    private func viewConst() {
        addSubview(cardNumLabel)
        addSubview(deleteButton)
        addSubview(scrollView)
        scrollView.addSubview(frontCard)
        scrollView.addSubview(backCard)
        
        cardNumLabel.snp.makeConstraints { (make) in
            make.top.equalTo(snp.top).offset(16)
            make.left.equalTo(snp.left).offset(16)
        }
        
        deleteButton.snp.makeConstraints { (make) in
            make.top.equalTo(snp.top).offset(16)
            make.right.equalTo(snp.right).offset(-16)
            make.width.height.equalTo(32)
        }
        
        scrollView.snp.makeConstraints { (make) in
            make.left.equalTo(snp.left)
            make.width.equalTo(snp.width)
            make.top.equalTo(deleteButton.snp.bottom).offset(16)
            make.bottom.equalTo(snp.bottom).offset(-16)
        }
        
        frontCard.snp.makeConstraints { (make) in
            make.height.width.equalTo(scrollView.snp.height).multipliedBy(0.9)
            make.centerX.equalTo(scrollView.snp.centerX)
            make.centerY.equalTo(scrollView.snp.centerY)
        }
        
        backCard.snp.makeConstraints { (make) in
            make.height.width.equalTo(frontCard.snp.width)
            make.centerX.equalTo(scrollView.snp.centerX)
            make.centerY.equalTo(scrollView.snp.centerY)
        }
    }
    
    private func setupView() {
        frontCard.frontLabel.text = "Front"
        frontCard.layer.cornerRadius = 10
        frontCard.layer.borderWidth = 1
        frontCard.layer.shadowColor = UIColor.gray.cgColor
        frontCard.layer.shadowOffset = CGSize(width: -15, height: -15)
        frontCard.layer.shadowOpacity = 10
        frontCard.layer.shadowRadius = 12
        frontCard.backgroundColor = .white
        frontCard.layer.masksToBounds = true
        
        
        backCard.frontLabel.text = "Back"
        backCard.layer.cornerRadius = 10
        backCard.layer.borderWidth = 1
        backCard.layer.shadowColor = UIColor.gray.cgColor
        backCard.layer.shadowOffset = CGSize(width: -15, height: -15)
        backCard.layer.shadowOpacity = 10
        frontCard.layer.shadowRadius = 12
        backCard.backgroundColor = .white
        backCard.layer.masksToBounds = true
    }
}
