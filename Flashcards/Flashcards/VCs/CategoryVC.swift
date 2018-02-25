//
//  CategoryVC.swift
//  Flashcards
//
//  Created by C4Q on 2/20/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import FirebaseAuthUI

class CategoryVC: UIViewController {

    let authUI = FUIAuth.defaultAuthUI()
    let categoryView = CategoryView()
    let cellSpacing: CGFloat = 10.0
    
    var categories = [Category]() {
        didSet {
            DispatchQueue.main.async {
                self.categoryView.catCollectionView.reloadData()
            }
        }
    }
    
    var decks = [Deck]() {
        didSet {
            DispatchQueue.main.async {
                self.categoryView.deckTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //authUI?.delegate = self
        categoryView.addDeck.isEnabled = false
        categoryView.addDeck.addTarget(self, action: #selector(createDeck), for: .touchUpInside)
        viewControllerDelegations()
        navConfig()
        catViewConstraints()
        loadCategories()
    }
    
    private func navConfig() {
        view.backgroundColor = UIColor.white
        navigationController?.navigationBar.barTintColor = UIColor.init(red: 57/255, green: 119/255, blue: 224/255, alpha: 1)
        navigationController?.navigationBar.tintColor = .white
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        
        titleLabel.text = "Category"
        navigationItem.titleView = titleLabel
        navigationController?.navigationBar.isTranslucent = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "SignOut", style: .plain, target: self, action: #selector(userSignOut))
        
    }
    
    @objc private func userSignOut() {
        do {
            try authUI!.signOut()
            
        } catch {
            alertMessage(title: "SignOut", message: "SignOut failed, please try again.")
        }
        navigationController?.dismiss(animated: true, completion: nil)
        if let authViewController = authUI?.authViewController() {
            self.present(authViewController, animated: true, completion: nil)
        }
    }
    
    private func alertMessage(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okButton)
        present(alertController, animated: true, completion: nil)
    }
    
    private func viewControllerDelegations() {
        categoryView.catCollectionView.delegate = self
        categoryView.catCollectionView.dataSource = self
        categoryView.deckTableView.delegate = self
        categoryView.deckTableView.dataSource = self
    }
    
    @objc private func createDeck() {
        let indexPath = categoryView.catCollectionView.indexPathsForSelectedItems![0]
        let deckVC = AddDeckVC()
        deckVC.cat = categories[indexPath.row - 1]
        navigationController?.pushViewController(deckVC, animated: true)
    }
    
    private func loadCategories() {
        let dbRef = Database.database().reference()
        let getCats = dbRef.child("categories")
        getCats.observe(.value) { (snapShot) in
            var cats = [Category]()
            for child in snapShot.children {
                let newCat = Category(snapShot: child as! DataSnapshot)
                cats.append(newCat)
            }
            self.categories = cats
        }
    }
    
    private func catViewConstraints() {
        view.addSubview(categoryView)
        categoryView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
    }

}

