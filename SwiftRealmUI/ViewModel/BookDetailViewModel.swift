//
//  BookDetailViewModel.swift
//  SwiftRealmUI
//
//  Created by Guanxiong Cao  on 28/12/2016.
//  Copyright © 2016 Guanxiong Cao . All rights reserved.
//

import Foundation

struct BookDetailViewModel {
    
    let book: Book
    
    func bookID() -> Int {
        return book.id
    }
    
    func name() -> String {
        return book.name
    }
    
    func author() -> String {
        return book.author
    }
    
    func status() -> String {
        return book.displayedStatus
    }
    
    func buttonTitle() -> String {
        return book.displayedButton
    }
}
