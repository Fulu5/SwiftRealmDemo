//
//  DetailViewController.swift
//  SwiftRealmUI
//
//  Created by Guanxiong Cao  on 27/12/2016.
//  Copyright © 2016 Guanxiong Cao . All rights reserved.
//

import UIKit
import RealmSwift

class DetailViewController: UIViewController {
    
    var book: BookModel!

    @IBOutlet weak var bookName: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var available: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        bookName.text = book.name
        author.text = book.author
        available.text = book.borrowedBy != nil ? "Not available" : "Available"
    }
}
