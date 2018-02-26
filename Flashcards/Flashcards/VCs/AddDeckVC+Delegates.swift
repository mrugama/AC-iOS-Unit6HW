//
//  AddDeckVC+ImagePickerDelegate.swift
//  Flashcards
//
//  Created by C4Q on 2/19/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

// MARK:- ImagePickerController Delegate
extension AddDeckVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            if let indexPath = self.indexPath {
                self.cards[indexPath.row].image = pickedImage
                self.indexPath = nil
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
}

// MARK: - TextField delegate
extension AddDeckVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text, text.count > 0 {
            publishButton.isEnabled = true
            addCardButton.isHidden = false
        } else {
            publishButton.isEnabled = false
            addCardButton.isHidden = true
        }
        return true
    }
}

//MARK:- TableViewCell Delegate
extension AddDeckVC: NewCardCellDelegate {
    @objc func didAddImageBtnPressed(_ cell: DeckTableViewCell) {
        if let indexPath = self.tableView.indexPath(for: cell) {
            self.indexPath = indexPath
        }
        openMenuPhotos()
    }
    
    @objc internal func didSaveCardSucceed(_ cell: DeckTableViewCell) {
        if let indexPath = self.tableView.indexPath(for: cell) {
            var newCard: Card = cards[indexPath.row]
            print(indexPath.row)
            if let question = cell.addDeck.frontCard.captionTxtView.text {
                newCard.question = question
            }
            if let answer = cell.addDeck.backCard.captionTxtView.text {
                newCard.answer = answer
            }
            cards[indexPath.row] = newCard
        }
        addCardButton.isHidden = false
    }
    
    @objc func didDeleteCardPressed(_ cell: DeckTableViewCell) {
        if let indexPath = self.tableView.indexPath(for:  cell) {
            cards.remove(at: indexPath.row)
        }
    }
}
