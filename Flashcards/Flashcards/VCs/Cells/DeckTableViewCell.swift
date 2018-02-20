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
    
    func configureCell(card: Int) {
        addDeck.cardNumLabel.text = "Card: \(card + 1)"
        addDeck.backCard.isHidden = true
        
        configureConstraints()
    }
    
    private func configureConstraints() {
        addSubview(addDeck)
        addDeck.snp.makeConstraints { (make) in
            make.edges.equalTo(snp.edges)
        }
    }
}
