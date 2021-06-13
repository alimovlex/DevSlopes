//
//  UserDataService.swift
//  Smack
//
//  Created by robot on 6/14/21.
//  Copyright © 2021 robot. All rights reserved.
//

import Foundation

class UserDataService {
    
    static let instance = UserDataService();
    
    public private(set) var id = "";
    public private(set) var avatarColor = "";
    public private(set) var avatarName = "";
    public private(set) var email = "";
    public private(set) var name = "";

    func setUserData(id: String, color: String, avatarName: String, email: String, name: String) {
        self.id = id;
        self.avatarColor = color;
        self.avatarName = avatarName;
        self.name = name;
        self.email = email;
    }
    
    func setAvatarName(avatarName: String) {
        self.avatarName = avatarName;
    }

}
