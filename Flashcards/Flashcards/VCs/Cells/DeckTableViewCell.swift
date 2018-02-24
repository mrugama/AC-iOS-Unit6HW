//
//  DeckCollectionViewCell.swift
//  Flashcards
//
//  Created by C4Q on 2/16/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class DeckTableViewCell: UITableViewCell {
    
    var addDeck = AddDeckView()
    
    func configureCell(num: Int, card: Card) {
        addDeck.cardNumLabel.text = "Card: \(num + 1)"
        addDeck.backCard.isHidden = true
        addDeck.frontCard.saveButton.addTarget(self, action: #selector(flipBtn), for: .touchUpInside)
        configureConstraints()
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
    
    private func configureConstraints() {
        addSubview(addDeck)
        addDeck.snp.makeConstraints { (make) in
            make.edges.equalTo(snp.edges)
        }
    }
}
