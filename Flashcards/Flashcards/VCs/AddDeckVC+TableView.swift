//
//  AddDeckVC+TableView.swift
//  Flashcards
//
//  Created by C4Q on 2/20/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

extension AddDeckVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.layer.frame.height * 0.55
    }
}

extension AddDeckVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "DeckCell", for: indexPath) as? DeckTableViewCell {
            let card = cards[indexPath.row]
            cell.configureCell(num: indexPath.row, card: card)
            cell.delegateCell = self
            return cell
        }
        
        return UITableViewCell()
    }
}
