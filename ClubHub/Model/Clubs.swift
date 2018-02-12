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

class Clubs {
    
    let clubName: String?
    let categories: [String]?
    let imageUrl: String?
    
    init(clubName: String, categories: [String]?, imageUrl: String?) {
        self.clubName = clubName
        self.categories = categories
        self.imageUrl = imageUrl
    }
    
    init(imageUrl: String?){
        self.imageUrl = imageUrl
        self.categories = nil
        self.clubName = nil
    }
    
//    static func fetchClubList( completionBlock: @escaping (_ post: Clubs?, _ error: String?) -> Void){
//        if Auth.auth().currentUser != nil{
//            DataService.ds.REF_CLUBS.addSnapshotListener { (querySnapshot, error) in
//                guard let postChanges = querySnapshot else{
//                    print("Error fetching document: \(error!)")
//                    return
//                }
//                postChanges.documentChanges.forEach({ (diff) in
//                    if diff.type == .added || diff.type == .modified || diff.type == .removed{
////                        let documentID = diff.document.documentID
//                        let clubName = diff.document.data()["Club Name"] as? String
//                        let url = diff.document.data()["Url"] as? String
//                        let post = Clubs(clubName: clubName!, categories: nil, imageUrl: url)
//                        completionBlock(post, nil)
//
//                    }
//                })
//
//            }
//
//        }else{
//            let errorMessage = "Data fecth error: user could not be authenitcated."
//            completionBlock(nil, errorMessage)
//        }
//
//    }
    
    static func fetchClubs( completionBlock: @escaping (_ clubs: Clubs?, _ error: String?) -> Void){
        if Auth.auth().currentUser != nil{
            DataService.ds.REF_USERS.whereField("Club", isEqualTo: true).addSnapshotListener({ (querySnapshot, error) in
                guard let clubs = querySnapshot else{
                    completionBlock(nil, error as? String)
                    return
                }
                for document in clubs.documents{
                    let clubName = document.data()["User Name"]!
                    let imageUrl = document.data()["Url"]
                    let clubs = Clubs(clubName: clubName as! String, categories: nil, imageUrl: imageUrl as? String)
                    completionBlock(clubs, nil)
                }
            })
        }else{
            let errorMessage = "Data fecth error: user could not be authenitcated."
            completionBlock(nil, errorMessage)
        }
    }
    
    static func searchClub(_ club: String?, completionBlock: @escaping (_ club: Clubs?, _ error: String?) -> Void){
        if Auth.auth().currentUser != nil{
            DataService.ds.REF_USERS.whereField("User Name", isEqualTo: club!).addSnapshotListener({ (querySnapshot, error) in
                guard let club = querySnapshot else{
                    completionBlock(nil, error as? String)
                    return
                }
                for document in club.documents{
                    let imageUrl = document.data()["Url"]
                    let club = Clubs(imageUrl: imageUrl as? String)
                    completionBlock(club, nil)
                }
            })
            
        }else{
            print("Authentication error")
        }
        
    }
    
}

