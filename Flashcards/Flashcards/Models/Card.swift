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
    var id: Int?
    var name: String?
    var question: String?
    var answer: String?
    var imageURL: String?
    var image: UIImage?
    var saved: Bool?
    
    init(ref: DatabaseReference, refId: String,
         id: Int, name: String, question: String,
         answer: String, imageURL: String, saved: Bool) {
        self.ref = ref
        self.refId = refId
        self.id = id
        self.name = name
        self.question = question
        self.answer = answer
        self.imageURL = imageURL
        self.image = nil
        self.saved = saved
    }
    
    init(snapShot: DataSnapshot) {
        let value = snapShot.value as? [String: Any]
        self.ref = snapShot.ref
        self.refId = value?["refId"] as? String ?? ""
        self.id = value?["id"] as? Int ?? 0
        self.name = value?["name"] as? String ?? ""
        self.question = value?["question"] as? String ?? ""
        self.answer = value?["answer"] as? String ?? ""
        self.imageURL = value?["imageURL"] as? String ?? ""
        self.image = nil
        self.saved = true
    }
    
    func toAnyObj() -> [String: Any] {
        return ["refId": refId ?? "", "id": id ?? 0,
                "name": name ?? "", "question": question ?? "",
                "answer": answer ?? "", "imageURL": imageURL ?? ""]
    }
}
