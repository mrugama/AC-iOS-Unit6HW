//
//  AddDeckVC+ImagePickerDelegate.swift
//  Flashcards
//
//  Created by C4Q on 2/19/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

extension AddDeckVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            if let indexPath = self.indexPath {
                print(indexPath.row)
                self.cards[indexPath.row].image = pickedImage
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
