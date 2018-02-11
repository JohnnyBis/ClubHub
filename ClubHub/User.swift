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
    var club: Bool?
    var clubs: Array<String>?
    
    
    init(userName: String?, userEmail: String?, userGrade: String?, club: Bool?, imageUrl: String?, clubs: Array<String>?){
        self.name = userName
        self.email = userEmail
        self.grade = userGrade
        self.club = club
        self.profileUrl = imageUrl
        self.clubs = clubs
        
    }
    
    init(userName: String?, imageUrl: String?){
        self.name = userName
        self.profileUrl = imageUrl
    }
    
    
//    init(url: URL?){
//        self.profileUrl = url
//    }
    
    
    static func fetchUserData(_ userID: String, completionBlock: @escaping (_ userData: User?, _ error: String?) -> Void){
        
        DataService.ds.REF_USERS.document(userID).getDocument { (doc, error) in
                if error != nil{
                    completionBlock(nil, error! as? String)
                }else{
                    let userEmail = doc?.data()["Email"] as? String
                    let userGrade = doc?.data()["Grade"] as? String
                    let imageUrl = doc?.data()["Url"] as? String
                    let userName = doc?.data()["User Name"] as? String
                    let club = doc?.data()["Club"] as? Bool
                    let clubs = doc?.data()["Clubs"] as? Array<String>
                    let user = User(userName: userName, userEmail: userEmail, userGrade: userGrade, club: club, imageUrl: imageUrl, clubs: clubs)
                    completionBlock(user, nil)
    
                }
            }
      
        
    }
    
    static func fetchUserPostData(_ userID: String, completionBlock: @escaping (_ user: User?, _ error: String?) -> Void){
        DataService.ds.REF_USERS.document(userID).getDocument { (doc, error) in
            if error != nil{
                completionBlock(nil, error! as? String)
            }else{
                let userName = doc?.data()["User Name"] as? String
                let imageUrl = doc?.data()["Url"] as? String
                let userPost = User(userName: userName, imageUrl: imageUrl)
                completionBlock(userPost, nil)
            }
        }

    }
    
    static func fetchUserClubs(_ userID: String?, completionBlock: @escaping (_ clubs: Array<String>?, _ error: String?) -> Void){
        
        DataService.ds.REF_USERS.document(userID!).getDocument { (doc, error) in
            if error != nil{
                completionBlock(nil, error! as? String)
            }else{
                if let clubs = doc?.data()["Clubs"] as? Array<String>{
                    completionBlock(clubs, nil)
                    
                }else{
                    let newClubList = [String]()
                    completionBlock(newClubList, nil)
                }
                
            }
        }
        
    }
    
//    DataService.ds.REF_USERS.document(userID!).updateData(["Clubs": ""])

    static func addClub(userID: String?, clubName: String?){
        let message = "Successfully added club to user's"
        
        User.fetchUserClubs(userID) { (clubs, error) in
            if error != nil{
                print(error!)
            }else{
                var cub = clubs
                cub?.append(clubName!)
                DataService.ds.REF_USERS.document(userID!).updateData(["Clubs": cub!]) { (error) in
                    if error != nil{
                        print(error!)
                    }else{
                        print(message)
                    }
                }
                
            }
        }
        
    }
    
    
    
    

    
    
}
