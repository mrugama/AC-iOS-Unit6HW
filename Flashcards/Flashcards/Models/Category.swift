//
//  Category.swift
//  Flashcards
//
//  Created by C4Q on 2/19/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
import Firebase

struct Category {
    let ref: DatabaseReference?
    let refId: String?
    var name: String?
    
    init(ref: DatabaseReference?, name: String?) {
        self.ref = ref
        self.refId = ref?.key
        self.name = name
    }
    
    init(snapShot: DataSnapshot) {
        let value = snapShot.value as? [String: Any]
        self.ref = snapShot.ref
        self.refId = snapShot.ref.key
        self.name = value?["name"] as? String ?? ""
    }
    
    func toAnyObj() -> [String: Any] {
        return ["refId": refId ?? "", "name": name ?? ""]
    }
}
