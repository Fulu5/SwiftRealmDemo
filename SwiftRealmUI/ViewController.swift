//
//  ViewController.swift
//  SwiftRealmUI
//
//  Created by Guanxiong Cao  on 27/12/2016.
//  Copyright © 2016 Guanxiong Cao . All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class ViewController: UIViewController {
    
    let realm = try! Realm()
    var notificationToken: RLMNotificationToken!
    
    @IBOutlet weak var tableView: UITableView!
    
    let userTableViewCellReuse = "UserTableViewCell"
    let bookTableViewCellReuse = "BookTableViewCell"
    let user = UserModel()
//    var bookArray = [BookModel]()
    var results: Results<BookModel>!
    
    deinit {
        notificationToken.stop()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // realm的通知中心
        results = realm.objects(BookModel.self)
        notificationToken = results.addNotificationBlock {
            [weak self](changes: RealmCollectionChange) in
            guard let tableView = self?.tableView else { return }
            
            switch changes {
            case .initial: tableView.reloadData(); break
            case .update(_, _, _, let modifications):
                tableView.beginUpdates()
                let indexs = modifications.map({ IndexPath(row: $0, section: 0)})
                tableView.reloadRows(at: indexs, with: .automatic)
                tableView.endUpdates()
                break
            case .error: fatalError(); break
            }
        }
        
        getUserData()
        tableView.delegate = self
        tableView.dataSource = self
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
            let indexPath = tableView.indexPath(for: cell)!
            detailVC.book = results[indexPath.row]
        }
    }
}

// tableView
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let userCell = tableView.dequeueReusableCell(withIdentifier: userTableViewCellReuse,
                                                         for: indexPath) as! UserTableViewCell
            userCell.configCellWithUserModel(user: user)
            return userCell
        }
        let bookCell = tableView.dequeueReusableCell(withIdentifier: bookTableViewCellReuse,
                                                     for: indexPath) as! BookTableViewCell
        bookCell.configCellWithBookModel(book: results[indexPath.row])
        return bookCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
