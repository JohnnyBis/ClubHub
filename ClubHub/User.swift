//
//  User.swift
//  ClubHub
//
//  Created by Gianmaria Biselli on 1/27/18.
//  Copyright © 2018 Gianmaria Biselli. All rights reserved.
//

import Foundation
import FirebaseAuth
import Firebase

struct User{
    
    var name: String?
    var email: String?
    var grade: String?
    var profileUrl: String?
    
    
//    init(userName: String?, userEmail: String?, userGrade: String?){
//        self.name = userName
//        self.email = userEmail
//        self.grade = userGrade
//        
//    }
    
//    init(url: URL?){
//        self.profileUrl = url
//    }
    
    
    static func fetchUserData(_ userID: String, completionBlock: @escaping (_ userName: String?, _ userEmail: String?, _ userGrade: String?, _ url: String?, _ club: Bool?, _ error: String?) -> Void){
        
        DataService.ds.REF_USERS.document(userID).getDocument { (doc, error) in
                if error != nil{
                    completionBlock(nil, nil, nil, nil, nil, error! as? String)
                }else{
                    let userEmail = doc?.data()["Email"] as? String
                    let userGrade = doc?.data()["Grade"] as? String
                    let imageUrl = doc?.data()["Url"] as? String
                    let userName = doc?.data()["User Name"] as? String
                    let club = doc?.data()["Club"] as? Bool
                    completionBlock(userName, userEmail, userGrade, imageUrl, club, nil)
                    
                    
                }
            }
      
        
    }
    
    static func fetchUserClubs(_ userID: String?, completionBlock: @escaping (_ clubs: Array<String>?, _ error: String?) -> Void){
        
        DataService.ds.REF_USERS.document(userID!).getDocument { (doc, error) in
            if error != nil{
                completionBlock(nil, error! as? String)
            }else{
                let clubs = doc?.data()["Subscriptions"] as? Array<String>
                completionBlock(clubs, nil)
                
            }
        }
        
    }
    
    
    
    

    
    
}
