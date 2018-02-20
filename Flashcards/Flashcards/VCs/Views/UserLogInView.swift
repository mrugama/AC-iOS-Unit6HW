//
//  UserLogInView.swift
//  Flashcards
//
//  Created by C4Q on 2/12/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class UserLogInView: UIView {

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Login / Register"
        return label
    }()
    
    lazy var userNameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "USERNAME"
        return tf
    }()

    lazy var passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "PASSWORD"
        return tf
    }()
    
    
}
