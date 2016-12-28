//
//  Book.swift
//  SwiftRealmUI
//
//  Created by Guanxiong Cao  on 28/12/2016.
//  Copyright © 2016 Guanxiong Cao . All rights reserved.
//

import Foundation

struct Book {
    let id: Int
    let name: String
    let author: String
    let status: Bool
}

extension Book {
    var displayedStatus: String {
        return status ? "Available" : "Not Available"
    }
}
