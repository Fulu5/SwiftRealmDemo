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
    
    let realm = try! Realm()
    var user: UserModel!
    var book: BookModel!

    @IBOutlet weak var bookName: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var available: UILabel!
    @IBOutlet weak var borrowButton: UIButton!

    @IBAction func buttonAction(_ sender: UIButton) {
        
        let currentBook = realm.objects(BookModel.self).filter("name = %@", book.name).last!
        // current是上一次点击按钮保存的数据
        let title = currentBook.available != "Available" ? "Borrow me" : "Back me"
        borrowButton.setTitle(title, for: .normal)
        if currentBook.available == "Available" {
            // 可以借时
            available.text = "Not Available"
            try! realm.write {
                // 更改书的状态
                currentBook.available = available.text
                // 给用户添加条目
                user.books.append(book)
            }
        } else {
            // 不可以借时
            available.text = "Available"
            try! realm.write {
                currentBook.available = available.text
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setValue()
    }
    
    
    
    func setValue() {
        bookName.text = book.name
        author.text = book.author
        available.text = book.available
        let title = book.available != "Available" ? "Back me" : "Borrow me"
        borrowButton.setTitle(title, for: .normal)
    }
}

//extension DetailViewController: UINavigationControllerDelegate {
//    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        if operation == .pop {
//            let viewController = toVC as! ViewController
//            viewController.view.backgroundColor = UIColor.red
//        }
//        return nil
//    }
//}
