//
//  Card.swift
//  Flashcards
//
//  Created by C4Q on 2/19/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import Firebase

struct Card {
    let ref: DatabaseReference?
    let refId: String?
    let refDeckId: String?
    var question: String?
    var answer: String?
    var frontImageURL: String?
    var backImageURL: String?
    var image: UIImage?
    var saved: Bool?
    
    init(ref: DatabaseReference?, refId: String?,
         refDeckId: String?, question: String?,
         answer: String?, frontImageURL: String?, backImageURL: String?, saved: Bool?) {
        self.ref = ref
        self.refId = refId
        self.refDeckId = refDeckId
        self.question = question
        self.answer = answer
        self.frontImageURL = frontImageURL
        self.backImageURL = backImageURL
        self.image = nil
        self.saved = saved
    }
    
    init(snapShot: DataSnapshot) {
        let value = snapShot.value as? [String: Any]
        self.ref = snapShot.ref
        self.refId = value?["refId"] as? String ?? ""
        self.refDeckId = value?["refDeckId"] as? String ?? ""
        self.question = value?["question"] as? String ?? ""
        self.answer = value?["answer"] as? String ?? ""
        self.frontImageURL = value?["frontImageURL"] as? String ?? ""
        self.backImageURL = value?["backImageURL"] as? String ?? ""
        self.image = nil
        self.saved = true
    }
    
    func toAnyObj() -> [String: Any] {
        return ["refId": refId ?? "",
                "refDeckId": refDeckId ?? "",
                "question": question ?? "","answer": answer ?? "",
                "frontImageURL": frontImageURL ?? "",
                "backImageURL": backImageURL ?? ""]
    }
}
