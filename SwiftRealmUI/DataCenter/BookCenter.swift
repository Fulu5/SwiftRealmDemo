//
//  BookCenter.swift
//  SwiftRealmUI
//
//  Created by Guanxiong Cao  on 28/12/2016.
//  Copyright © 2016 Guanxiong Cao . All rights reserved.
//

import Foundation
import RealmSwift

enum NotificationType {
    case modifications(modifiedIndexes: [Int], results: [Book])
}

struct BookCenter: BookDataProtocol {
    
    // Realm的通知中心
    var notificatinToken: NotificationToken!

    mutating func getBooksFromDB(notificationHandler: ((_ type: NotificationType) -> Void)?) -> [Book] {
        // 将[RealmBook]转化为[Book]
        func mapResults(_ results: Results<RealmBook>) -> [Book] {
            return Array(results).map({
                Book(id: $0.id, name: $0.name, author: $0.author, status: $0.status)
            })
        }
        // 从数据库中取出原始数组
        let realm = try! Realm()
        let results = realm.objects(RealmBook.self)
        // 对原始数组的改动进行操作
        notificatinToken = results.addNotificationBlock({ (changes) in
            switch changes {
                // 值改变
            case .update(let value, _, _, let modifications):
                if modifications.count != 0 {
                    // 将改动了的index和改动后的数组传给闭包
                    notificationHandler?(.modifications(modifiedIndexes: modifications, results: mapResults(value)))
                }
                break
            default:break
            }
        })
        // 返回需要的数组
        return mapResults(results)
    }
    
    func saveBooksToDB() {
        for i in 1...10 {
            let realmBook = RealmBook(value: ["id": i, "name": "book - \(i)", "author": "author - \(i)", "status": false])
            addRealmBook(book: realmBook)
        }
    }
    func addRealmBook(book: RealmBook) -> Void {
        DispatchQueue.global().async {
            let realm = try! Realm()
            try! realm.write {
                realm.add(book)
            }
        }
    }
    
    func getBookWithID(id: Int) -> Book? {
        let realm = try! Realm()
        guard let realmBook = realm.objects(RealmBook.self).filter("id = %@", id).first else { return nil }
        return bookFromRealmBook(realmBook: realmBook)
    }
    
    func changeBookStatus(id: Int, successHandler: @escaping (_ book: Book) -> Void) {
        DispatchQueue.global().async {
            let realm = try! Realm()
            if let realmBook = realm.objects(RealmBook.self).filter("id = %@", id).first {
                try! realm.write {
                    // 更新数据库
                    realmBook.status = !realmBook.status
                }
                // 将更新后的数据回调
                let book = self.bookFromRealmBook(realmBook: realmBook)
                DispatchQueue.main.async {
                    successHandler(book)
                }
            }
        }
    }
    // 将realmBook转化为book
    func bookFromRealmBook(realmBook: RealmBook) -> Book {
        return Book(id: realmBook.id, name: realmBook.name, author: realmBook.author, status: realmBook.status)
    }
}
