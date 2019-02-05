//
//  Category.swift
//  KaroNa
//
//  Created by Vishnu V Ram on 2/1/19.
//  Copyright © 2019 Shannthini. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var backgroundColor: String = ""
    let items = List<Item>()
}
