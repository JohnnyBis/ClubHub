//
//  Clubs.swift
//  ClubHub
//
//  Created by Gianmaria Biselli on 1/31/18.
//  Copyright © 2018 Gianmaria Biselli. All rights reserved.
//

import Foundation
import FirebaseAuth
import Firebase

struct Clubs {
    
    let title: String
    let categories: [String]
    
    init(title: String, categories: [String]) {
        self.title = title
        self.categories = categories
    }
    
    func fetchClubList(){
        if Auth.auth().currentUser != nil{
            
        }
        
    }
    
}

