//
//  ViewController.swift
//  SwiftRealmUI
//
//  Created by Guanxiong Cao  on 27/12/2016.
//  Copyright © 2016 Guanxiong Cao . All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    let realm = try! Realm(configuration: Realm.Configuration(inMemoryIdentifier: "TemporaryRealm_book"))
    
    @IBOutlet weak var tableView: UITableView!
    let userTableViewCellReuse = "UserTableViewCell"
    let bookTableViewCellReuse = "BookTableViewCell"
    let user = UserModel()
    let book = BookModel()    
    var bookArray = [BookModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getBookData()
        getUserData()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func getBookData() {
        for i in 0...20 {
            let key = "book\(i)"
            let value = "author\(i)"
            let book = BookModel()
            book.name = key
            book.author = value
            bookArray.append(book)
        }
    }
    
    func getUserData() {
        user.name = "Mr.Zombie"
        user.tele = "+86 110 120 119"
        user.avatar = "Icon.png"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailVC" {
            let detailVC = segue.destination as! DetailViewController
            let cell = sender as! BookTableViewCell
            detailVC.book = bookArray[(tableView.indexPath(for: cell)?.row)!]
        }
    }
}

// tableView
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let userCell = tableView.dequeueReusableCell(withIdentifier: userTableViewCellReuse, for: indexPath) as! UserTableViewCell
            userCell.configCellWithUserModel(user: user)
            return userCell
        }
        let bookCell = tableView.dequeueReusableCell(withIdentifier: bookTableViewCellReuse, for: indexPath) as! BookTableViewCell
        bookCell.configCellWithBookModel(book: bookArray[indexPath.row])
        return bookCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
