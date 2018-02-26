//
//  Deck.swift
//  Flashcards
//
//  Created by C4Q on 2/23/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
import Firebase

struct Deck {
    let ref: DatabaseReference?
    let refId: String?
    let catId: String?
    var name: String?
    
    init(ref: DatabaseReference?, catId: String?, name: String?) {
        self.ref = ref
        self.refId = ref?.key
        self.catId = catId
        self.name = name
    }
    
    init(snapShot: DataSnapshot) {
        let value = snapShot.value as? [String: Any]
        self.ref = snapShot.ref
        self.refId = snapShot.ref.key
        self.catId = value?["catId"] as? String ?? ""
        self.name = value?["name"] as? String ?? ""
    }
    
    func toAnyObj() -> [String: Any] {
        return ["refId": refId ?? "",
                "catId": catId ?? "",
                "name": name ?? ""]
    }
}
