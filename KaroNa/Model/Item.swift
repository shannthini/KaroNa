//
//  Item.swift
//  KaroNa
//
//  Created by Vishnu V Ram on 2/1/19.
//  Copyright © 2019 Shannthini. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    let parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
