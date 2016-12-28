//
//  DataCenter.swift
//  SwiftRealmUI
//
//  Created by Guanxiong Cao  on 28/12/2016.
//  Copyright © 2016 Guanxiong Cao . All rights reserved.
//

import Foundation

protocol UserDataProtocol {
    // 从数据库取值
    func getUserFromDB() -> User?
    // 向数据库存储用户信息
    func saveUserToDB()
}

protocol BookDataProtocol {
    // 从数据库获取数据
    mutating func getBooksFromDB(notificationHandler: ((_ type: NotificationType) -> Void)?) -> [Book]
    // 向数据库保存数据
    func saveBooksToDB()
    // 通过id查询数据库
    func getBookWithID(id: Int) -> Book?
    // 改变状态
    func changeBookStatus(id: Int, successHandler: @escaping (_ book: Book) -> Void)
}
