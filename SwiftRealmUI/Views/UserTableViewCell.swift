//
//  UserTableViewCell.swift
//  SwiftRealmUI
//
//  Created by Guanxiong Cao  on 27/12/2016.
//  Copyright © 2016 Guanxiong Cao . All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userTele: UILabel!
    @IBOutlet weak var userAvatar: UIImageView!
    
    func configCell(userInfo: (name: String, count: String, avatar: String)) {
        userName.text = userInfo.name
        userTele.text = userInfo.count
        userAvatar.image = UIImage(named: userInfo.avatar)
    }
}
