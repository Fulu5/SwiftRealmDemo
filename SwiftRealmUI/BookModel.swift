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
    var name: String!
    var author: String!
    dynamic var borrowedBy: UserModel?
}
