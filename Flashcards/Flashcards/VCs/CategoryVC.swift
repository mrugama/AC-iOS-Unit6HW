//
//  CategoryVC.swift
//  Flashcards
//
//  Created by C4Q on 2/20/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import FirebaseDatabase

class CategoryVC: UIViewController {

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
        categoryView.catCollectionView.delegate = self
        categoryView.catCollectionView.dataSource = self
        categoryView.deckTableView.delegate = self
        categoryView.deckTableView.dataSource = self
        categoryView.addDeck.isEnabled = false
        categoryView.addDeck.addTarget(self, action: #selector(createDeck), for: .touchUpInside)
        navConfig()
        catViewConstraints()
        loadCategories()
    }
    
    private func navConfig() {
        view.backgroundColor = UIColor.white
        navigationItem.title = "CATEGORIES"
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
