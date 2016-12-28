//
//  BookListViewModel.swift
//  SwiftRealmUI
//
//  Created by Guanxiong Cao  on 28/12/2016.
//  Copyright © 2016 Guanxiong Cao . All rights reserved.
//

import Foundation

struct BookListViewModel {
    var books: [Book]
    var user: User?
    
    init(books: [Book], user: User?) {
        self.books = books
        self.user = user
    }
    mutating func setBooks(_ newBooks: [Book]) {
        books = newBooks
    }
    
    func bookCount() -> Int {
        return books.count
    }
    
    func bookAtIndex(_ index: Int) -> Book {
        return books[index]
    }
    
    func userInfo() -> (name: String, count: String, avatar: String) {
        return (name: user?.name ?? "", count: "\(books.count) total", avatar: "Icon.png")
    }
}
