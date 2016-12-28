//
//  UserCenter.swift
//  SwiftRealmUI
//
//  Created by Guanxiong Cao  on 28/12/2016.
//  Copyright © 2016 Guanxiong Cao . All rights reserved.
//

import Foundation
import RealmSwift

struct UserCenter: UserDataProtocol {

    func getUserFromDB() -> User? {
        let realm = try! Realm()
        guard let user = realm.objects(RealmUser.self).first else { return nil }
        return User(id: user.id, name: user.name)
    }
    
    func saveUserToDB() {
        let realmUser = RealmUser(value: ["id": 0, "name": "Mr.Zombie"])
        DispatchQueue.global().async {
            let realm = try! Realm()
            try! realm.write {
                realm.add(realmUser)
            }
        }
    }
}
