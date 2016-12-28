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
    var user: User!
    var book: Book!

    @IBOutlet weak var bookName: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var available: UILabel!
    @IBOutlet weak var borrowButton: UIButton!

    @IBAction func buttonAction(_ sender: UIButton) {

    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setValue()
    }
    
    func setValue() {
        title = book.name == "" ? "Book Detail" : book.name
        bookName.text = book.name
        author.text = book.author
        
    }
}
