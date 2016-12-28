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
    
    let bookCenter = BookCenter()
    var bookDetailViewModel: BookDetailViewModel!
    

    @IBOutlet weak var bookName: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var available: UILabel!
    @IBOutlet weak var borrowButton: UIButton!

    @IBAction func buttonAction(_ sender: UIButton) {
        bookCenter.changeBookStatus(id: bookDetailViewModel.bookID()) {
            [weak self] book in
            if let strongSelf = self {
                strongSelf.available.text = book.displayedStatus
                strongSelf.borrowButton.setTitle(book.displayedButton, for: .normal)
            }
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setValue()
    }
    
    func setValue() {
        title = bookDetailViewModel.name()
        bookName.text = title
        author.text = bookDetailViewModel.author()
        available.text = bookDetailViewModel.status()
        print(bookDetailViewModel.status())
        borrowButton.setTitle(bookDetailViewModel.buttonTitle(), for: .normal)
    }
}
