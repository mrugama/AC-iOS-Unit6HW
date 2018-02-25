//
//  AddDeckVC.swift
//  Flashcards
//
//  Created by C4Q on 2/15/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit
import FirebaseDatabase

class AddDeckVC: UIViewController {
    
    var dbRef: DatabaseReference?
    var newDeckRef: DatabaseReference?
    var indexPath: IndexPath?
    var cat: Category? {
        didSet {
            print(cat?.name ?? "No value")
        }
    }
    var cards = [Card]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    lazy var newDeckLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.gray
        label.text = "Create Deck"
        return label
    }()
    
    lazy var titleTextField: UITextField = {
        let tf = UITextField()
        tf.textAlignment = .center
        tf.placeholder = "Enter title"
        tf.autocorrectionType = .no
        return tf
    }()
    
    lazy var publishButton: UIButton = {
        let button = UIButton()
        button.setTitle("PUBLISH", for: UIControlState.normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor.init(red: 103/255, green: 179/255, blue: 233/255, alpha: 1)
        return button
    }()
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(DeckTableViewCell.self, forCellReuseIdentifier: "DeckCell")
        return table
    }()
    
    lazy var addCardButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "icoPlus64x64"), for: UIControlState.normal)
        button.tintColor = UIColor.white
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.layer.shadowColor = UIColor.lightGray.cgColor
        button.layer.shadowOffset = CGSize(width: 5, height: 10)
        button.layer.cornerRadius = 32
        button.backgroundColor = UIColor.init(red: 0.9, green: 0.1, blue: 0, alpha: 0.6)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        titleTextField.delegate = self
        addCardButton.addTarget(self, action: #selector(addNewCard), for: .touchUpInside)
        setupView()
        setupNavController()
        addCardButton.setNeedsLayout()
        publishButton.isEnabled = false
        addCardButton.isHidden = true
        dbRef = Database.database().reference()
    }
    
    private func setupNavController() {
        navigationItem.title = cat?.name
    }
    
    @objc private func addNewCard() {
        let newCard = Card(ref: nil, refId: nil, refCatId: cat?.refId, refDeckId: nil, name: nil, question: nil, answer: nil, frontImageURL: nil, backImageURL: nil, saved: false)
        cards.append(newCard)
        addCardButton.isHidden = true
    }
    
    private func setupView() {
        view.addSubview(newDeckLabel)
        view.addSubview(titleTextField)
        view.addSubview(publishButton)
        view.addSubview(tableView)
        view.addSubview(addCardButton)
        
        newDeckLabel.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.width.equalTo(view.snp.width)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        titleTextField.snp.makeConstraints { (make) in
            make.top.equalTo(newDeckLabel.snp.bottom).offset(16)
            make.width.equalTo(view.snp.width)
        }
        
        publishButton.snp.makeConstraints { (make) in
            make.top.equalTo(titleTextField.snp.bottom).offset(16)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(view.snp.width).multipliedBy(0.80)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(publishButton.snp.bottom).offset(16)
            make.width.equalTo(view.snp.width)
            make.bottom.equalTo(view.snp.bottom)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        addCardButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(view.snp.bottom).offset(-16)
            make.right.equalTo(view.snp.right).offset(-16)
            make.height.width.equalTo(64)
        }
    }
    
    @objc func saveCard(sender: UIButton) {
        addCardButton.isHidden = false
    }
    
    func openMenuPhotos() {
        let addImageActionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let openCamera = UIAlertAction.init(title: "Take a photo", style: .default) { [weak self] (action) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .camera;
                imagePicker.allowsEditing = false
                self?.present(imagePicker, animated: true, completion: nil)
            }
        }
        let openGallery = UIAlertAction(title: "Library", style: .default) { [weak self] (action) in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .photoLibrary;
                imagePicker.allowsEditing = false
                self?.present(imagePicker, animated: true, completion: nil)
            }
        }
        
        addImageActionSheet.addAction(openCamera)
        addImageActionSheet.addAction(openGallery)
        addImageActionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil) )
        self.present(addImageActionSheet, animated: true, completion: nil)
    }
}


extension AddDeckVC: NewCardViewDelegate, NewCardCellDelegate {
    @objc func didAddImageBtnPressed(sender: UIButton) {
        indexPath = IndexPath(item: sender.tag, section: 0)
        openMenuPhotos()
    }
    
    @objc internal func didSaveCardSucceed(_ tableViewCell: DeckTableViewCell) {
        if let indexPath = self.tableView.indexPath(for: tableViewCell) {
            var newCard: Card = cards[indexPath.row]
            newCard.question = tableViewCell.addDeck.frontCard.captionTxtView.text
            newCard.image = tableViewCell.addDeck.frontCard.imageView.image
            newCard.answer = tableViewCell.addDeck.backCard.captionTxtView.text
            print(tableViewCell.addDeck.backCard.captionTxtView.text)
            cards[indexPath.row] = newCard
        }
        addCardButton.isHidden = false
    }
    
//    @objc private func didSaveCardSucceed(indexPath: IndexPath) {
//        var newCard: Card = cards[indexPath.row]
//        if let cell = self.tableView.cellForRow(at: indexPath) as? DeckTableViewCell {
//            newCard.name = cell.addDeck.frontCard.captionTxtView.text
//            newCard.question = cell.addDeck.frontCard.captionTxtView.text
//            newCard.image = cell.addDeck.frontCard.imageView.image
//            newCard.answer = cell.addDeck.backCard.captionTxtView.text
//            cards[indexPath.row] = newCard
//        }
//        addCardButton.isHidden = false
//    }
}

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
