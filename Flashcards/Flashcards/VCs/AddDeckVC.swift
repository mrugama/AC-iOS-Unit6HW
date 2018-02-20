//
//  AddDeckVC.swift
//  Flashcards
//
//  Created by C4Q on 2/15/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class AddDeckVC: UIViewController {
    
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
        //button.setTitle("+", for: .normal)
        button.tintColor = UIColor.white
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.layer.shadowColor = UIColor.lightGray.cgColor
        button.layer.shadowOffset = CGSize(width: 5, height: 10)
        button.layer.cornerRadius = 32
        //button.backgroundColor = UIColor.init(red: 103/255, green: 179/255, blue: 233/255, alpha: 1)
        button.backgroundColor = UIColor.init(red: 0.9, green: 0.1, blue: 0, alpha: 0.6)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        addCardButton.setNeedsLayout()
        setupView()
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
    
    @objc private func addImageButtonPressed() {
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

extension AddDeckVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.layer.frame.height * 0.55
    }
}

extension AddDeckVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "DeckCell", for: indexPath) as? DeckTableViewCell {
            cell.configureCell(card: indexPath.row)
            cell.addDeck.frontCard.addImageBtn.addTarget(self, action: #selector(addImageButtonPressed), for: UIControlEvents.touchUpInside)
            cell.addDeck.backCard.addImageBtn.addTarget(self, action: #selector(addImageButtonPressed), for: UIControlEvents.touchUpInside)
            cell.addDeck.frontCard.delegate = self
            return cell
        }
        
        return UITableViewCell()
    }
}

extension AddDeckVC: NewCardViewDelegate {
    func didButtonPressed() {
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
        let openGallery = UIAlertAction(title: "From library", style: .default) { [weak self] (action) in
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
