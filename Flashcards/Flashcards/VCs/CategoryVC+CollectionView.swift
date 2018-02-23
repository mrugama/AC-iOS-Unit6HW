//
//  CategoryVC+CollectionView.swift
//  Flashcards
//
//  Created by C4Q on 2/23/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import FirebaseDatabase

extension CategoryVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        //cell?.layer.borderColor = UIColor.white.cgColor
        cell?.layer.borderWidth = 2.5
        self.categoryView.addDeck.isEnabled = true
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderWidth = 0
    }
}

extension CategoryVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numCells: CGFloat = 3
        let numSpaces: CGFloat = numCells + 1
        
        let cvWidth = collectionView.bounds.width
        let cvHeight = collectionView.bounds.height
        
        if indexPath.row == 0 {
            return CGSize(width: (cvWidth - (cellSpacing * numSpaces)) / (numCells + 3), height: (cvHeight - (cellSpacing * 5)))
        } else {
            return CGSize(width: (cvWidth - (cellSpacing * numSpaces)) / numCells, height: (cvHeight - (cellSpacing * 5)))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: cellSpacing, left: cellSpacing, bottom: cellSpacing, right: cellSpacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
    
    @objc func addNewCategory() {
        let alertController = UIAlertController(title: "New Category", message: nil, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter a category's name"
        }
        let cancelbtn = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let savebtn = UIAlertAction(title: "Save", style: .default) { (alertAction) in
            if let txtField = alertController.textFields?[0].text {
                self.saveCat(name: txtField)
            }
        }
        alertController.addAction(cancelbtn)
        alertController.addAction(savebtn)
        present(alertController, animated: true, completion: nil)
    }
    
    private func saveCat(name: String) {
        let dbRef = Database.database().reference()
        let newCatRef = dbRef.child("categories").childByAutoId()
        let newCat = Category(ref: newCatRef, name: name)
        newCatRef.setValue(newCat.toAnyObj())
    }
}

extension CategoryVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CatCellNew", for: indexPath) as? NewCatCollectionViewCell {
                cell.configCell()
                cell.newButton.addTarget(self, action: #selector(addNewCategory), for: .touchUpInside)
                return cell
            }
        } else {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CatCell", for: indexPath) as? CatCollectionViewCell {
                let cat = categories[indexPath.row - 1]
                cell.configCell(cat: cat)
                cell.layer.borderColor = UIColor.white.cgColor
                cell.layer.cornerRadius = 15
                cell.setNeedsLayout()
                return cell
            }
        }
        return UICollectionViewCell()
    }
}
