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
    
    var userCenter = UserCenter()
    var bookCenter = BookCenter()
    var viewModel: BookListViewModel!

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        print(NSHomeDirectory())
        title = "All Books"
        let books = bookCenter.getBooksFromDB(notificationHandler: bookStatusNotificationHandler())
        
        let user = userCenter.getUserFromDB()
        viewModel = BookListViewModel(books: books, user: user)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func bookStatusNotificationHandler() -> ((_ type: NotificationType) -> Void) {
        // 表示闭包中所有的self都是弱引用,需要解包
        return { [weak self] type in
            // 确保self没有被销毁
            guard let strongSelf = self else { return }
            switch type {
            case .modifications(let modifiedIndics, let value):
                strongSelf.viewModel.setBooks(value)
                strongSelf.tableView.beginUpdates()
                strongSelf.tableView.reloadRows(at: modifiedIndics.map({ IndexPath(row: $0, section: 0) }),
                                                with: .automatic)
                strongSelf.tableView.endUpdates()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailVC" {
            let detailVC = segue.destination as! DetailViewController
            let cell = sender as! BookTableViewCell
            let indexPath = tableView.indexPath(for: cell)!
            let book = viewModel.bookAtIndex(indexPath.row)
            if let selectedBook = bookCenter.getBookWithID(id: book.id) {
                let bookDetailViewModel = BookDetailViewModel(book: selectedBook)
                detailVC.bookDetailViewModel = bookDetailViewModel
            }
        }
    }
}

// tableView
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.bookCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let bookCell = tableView.dequeueReusableCell(withIdentifier: "BookTableViewCell",
                                                     for: indexPath) as! BookTableViewCell
        let book = viewModel.bookAtIndex(indexPath.row)
        bookCell.configCellWithBook(book)
        return bookCell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell") as! UserTableViewCell
        cell.configCell(userInfo: viewModel.userInfo())
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
}
