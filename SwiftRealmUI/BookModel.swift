//
//  BookModel.swift
//  SwiftRealmUI
//
//  Created by Guanxiong Cao  on 27/12/2016.
//  Copyright © 2016 Guanxiong Cao . All rights reserved.
//

import UIKit
import RealmSwift

class BookModel: Object {
    dynamic var name: String!
    dynamic var author: String!
    dynamic var available: String!
    let borrowedBy = LinkingObjects(fromType: UserModel.self, property: "books")
}
