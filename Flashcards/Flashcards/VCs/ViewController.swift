//
//  ViewController.swift
//  Flashcards
//
//  Created by C4Q on 2/12/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    var newDeck = AddDeckView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewContraints()
    }

    private func viewContraints() {
        view.addSubview(newDeck)
        newDeck.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
        }
    }

}

