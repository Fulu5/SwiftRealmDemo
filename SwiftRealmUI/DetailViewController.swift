//
//  DetailViewController.swift
//  SwiftRealmUI
//
//  Created by Guanxiong Cao  on 27/12/2016.
//  Copyright © 2016 Guanxiong Cao . All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class DetailViewController: UIViewController {
    
    let realm = try! Realm()
    var indexPath: IndexPath!
    var user: UserModel!
    var book: BookModel!

    @IBOutlet weak var bookName: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var available: UILabel!
    @IBOutlet weak var borrowButton: UIButton!

    @IBAction func buttonAction(_ sender: UIButton) {
        
        let oldBook = realm.objects(BookModel.self).filter("name = %@", book.name).last!
        if oldBook.available == "Available" {
            // 可以借时
            available.text = "Not Available"
            try! realm.write {
                // 更改书的状态
                oldBook.available = available.text
            }
        } else {
            // 不可以借时
            available.text = "Available"
            try! realm.write {
                oldBook.available = available.text
            }
        }
        // saved是数据库中的数据
        let title = oldBook.available == "Available" ? "Borrow me" : "Back me"
        borrowButton.setTitle(title, for: .normal)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setValue()
    }
    
    func setValue() {
        bookName.text = book.name
        author.text = book.author
        available.text = book.available
        let title = book.available == "Available" ? "Borrow mee" : "Back me"
        borrowButton.setTitle(title, for: .normal)
    }
}
