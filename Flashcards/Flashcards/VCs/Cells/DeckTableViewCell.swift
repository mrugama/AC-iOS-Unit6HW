//
//  DeckCollectionViewCell.swift
//  Flashcards
//
//  Created by C4Q on 2/16/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

@objc protocol NewCardCellDelegate: class {
    @objc optional func didAddImageBtnPressed(_ cell: DeckTableViewCell)
    @objc optional func didSaveCardSucceed(_ cell: DeckTableViewCell)
    @objc optional func didDeleteCardPressed(_ cell: DeckTableViewCell)
}

class DeckTableViewCell: UITableViewCell {
    
    weak var delegateCell: NewCardCellDelegate?
    var addDeck = AddDeckView()
    
    func configureCell(num: Int, card: Card) {
        addDeck.cardNumLabel.text = "Card: \(num + 1)"
        addDeck.backCard.isHidden = true
        if card.image == nil {
            addDeck.deleteButton.isEnabled = false
        }
        addDeck.deleteButton.addTarget(self, action: #selector(deleteCard), for: .touchUpInside)
        addDeck.frontCard.addImageBtn.addTarget(self, action: #selector(addImageCard), for: .touchUpInside)
        addDeck.frontCard.saveButton.addTarget(self, action: #selector(flipBtn), for: .touchUpInside)
        addDeck.backCard.saveButton.addTarget(self, action: #selector(saveCard), for: .touchUpInside)
        configureConstraints()
        if let image = card.image {
            addDeck.frontCard.imageView.image = image
            addDeck.frontCard.imageView.isHidden = false
            addDeck.frontCard.saveButton.isHidden = false
        } else {
            addDeck.backCard.addImageBtn.isHidden = true
        }
    }
    
    @objc func flipBtn() {
        addDeck.backCard.saveButton.setTitle("Save", for: .normal)
        UIView.transition(from: addDeck.frontCard,
                          to: addDeck.backCard,
                          duration: 1.0,
                          options: [.transitionFlipFromRight,
                                    .showHideTransitionViews],
                          completion: nil)
    }
    
    @objc private func saveCard() {
        addDeck.deleteButton.isEnabled = true
        delegateCell?.didSaveCardSucceed!(self)
        UIView.transition(from: addDeck.backCard,
                          to: addDeck.frontCard,
                          duration: 1.0,
                          options: [.transitionFlipFromRight,
                                    .showHideTransitionViews],
                          completion: nil)
    }
    
    @objc private func deleteCard(){
        delegateCell?.didDeleteCardPressed!(self)
    }
    
    @objc private func addImageCard() {
        delegateCell?.didAddImageBtnPressed!(self)
    }
    
    private func configureConstraints() {
        addSubview(addDeck)
        addDeck.snp.makeConstraints { (make) in
            make.edges.equalTo(snp.edges)
        }
    }
}
