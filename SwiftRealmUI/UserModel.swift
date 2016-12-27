//
//  UserModel.swift
//  SwiftRealmUI
//
//  Created by Guanxiong Cao  on 27/12/2016.
//  Copyright © 2016 Guanxiong Cao . All rights reserved.
//

import UIKit
import RealmSwift

class UserModel: Object {
    var name: String!
    var tele: String!
    var avatar: String!
    let books = List<BookModel>()
}
