//
//  User.swift
//  ClubHub
//
//  Created by Gianmaria Biselli on 1/27/18.
//  Copyright © 2018 Gianmaria Biselli. All rights reserved.
//

import Foundation

class User{
    
    var name: String?
    var email: String?
    var password: String?
    var grade: String?
    
    
    init(userName: String?, userEmail: String?, userPassword: String?, userGrade: String?){
        
        self.name = userName
        self.email = userEmail
        self.password = userPassword
        self.grade = userGrade
        
    }
    
    
    
    
    
    
}
