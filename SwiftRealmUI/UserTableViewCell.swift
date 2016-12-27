//
//  UserTableViewCell.swift
//  SwiftRealmUI
//
//  Created by Guanxiong Cao  on 27/12/2016.
//  Copyright © 2016 Guanxiong Cao . All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var userAvatar: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userTele: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configCellWithUserModel(user: UserModel) {
        userName.text = user.name
        userTele.text = user.tele
        userAvatar.image = UIImage(named: user.avatar)
    }
}
