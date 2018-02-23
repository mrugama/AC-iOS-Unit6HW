//
//  NewCard.swift
//  Flashcards
//
//  Created by C4Q on 2/15/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

@objc protocol NewCardViewDelegate: class {
    // select image from selected source
    @objc optional func didButtonPressed()
}

class NewCardView: UIView {
    
    weak var delegate: NewCardViewDelegate?
    
    lazy var frontLabel: UILabel = {
        let label = UILabel()
        label.text = "Front"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    lazy var addImageBtn: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "icoAddImage48x48"), for: .normal)
        button.addTarget(self, action: #selector(imageViewWillAppear), for: UIControlEvents.touchUpInside)
        return button
    }()
    
    lazy var captionTxtView: UITextView = {
        let text = UITextView()
        text.font = UIFont.boldSystemFont(ofSize: 18)
        text.textAlignment = .center
        text.autocorrectionType = UITextAutocorrectionType.no
        return text
    }()
    
    lazy var textButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(textViewWillAppear), for: UIControlEvents.touchUpInside)
        button.setImage(#imageLiteral(resourceName: "icoText32x32"), for: UIControlState.normal)
        return button
    }()
    
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        constraints()
        captionTxtView.isHidden = true
        imageView.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        captionTxtView.setNeedsLayout()
    }
    
    @objc private func textViewWillAppear() {
        captionTxtView.isHidden = false
        captionTxtView.becomeFirstResponder()
    }
    
    @objc private func imageViewWillAppear() {
        addImageBtn.isHidden = false
        captionTxtView.text = ""
        captionTxtView.isHidden = true
        self.delegate?.didButtonPressed!()
    }
    
    private func constraints() {
        addSubview(addImageBtn)
        addSubview(textButton)
        addSubview(frontLabel)
        addSubview(captionTxtView)
        addSubview(imageView)
        let paddin: CGFloat = 12
        
        addImageBtn.snp.makeConstraints { (make) in
            make.height.width.equalTo(paddin * 3)
            make.right.equalTo(snp.right).offset(-paddin)
            make.top.equalTo(snp.top).offset(paddin)
        }
        
        textButton.snp.makeConstraints { (make) in
            make.height.width.equalTo(paddin * 3)
            make.left.equalTo(snp.left).offset(paddin)
            make.top.equalTo(snp.top).offset(paddin)
        }
        
        frontLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(snp.centerX)
            make.top.equalTo(snp.top).offset(paddin * 2)
        }
        
        captionTxtView.snp.makeConstraints { (make) in
            make.left.equalTo(snp.left).offset(paddin * 2)
            make.right.equalTo(snp.right).offset(-paddin * 2)
            make.height.equalTo(snp.height).multipliedBy(0.6)
            make.bottom.equalTo(snp.bottom).offset(-paddin * 2)
        }
        
        imageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(snp.centerX)
            make.centerY.equalTo(snp.centerY)
            make.width.height.equalTo(snp.width).multipliedBy(0.6)
        }
    }
}
