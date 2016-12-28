//
//  BookTableViewCell.swift
//  SwiftRealmUI
//
//  Created by Guanxiong Cao  on 27/12/2016.
//  Copyright © 2016 Guanxiong Cao . All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    @IBOutlet weak var bookName: UILabel!
    @IBOutlet weak var bookAuthor: UILabel!
    @IBOutlet weak var available: UILabel!

    func configCellWithBook(_ book: Book) {
        bookName.text = book.name
        bookAuthor.text = book.author
        available.text = book.displayedStatus
    }
}
