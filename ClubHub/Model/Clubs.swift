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
    
    let clubName: String
    let categories: [String]?
    let imageUrl: String?
    
    init(clubName: String, categories: [String]?, imageUrl: String?) {
        self.clubName = clubName
        self.categories = categories
        self.imageUrl = imageUrl
    }
    
    static func fetchClubList(_ clubList: [Clubs], completionBlock: @escaping (_ post: Clubs?, _ error: String?) -> Void){
        if Auth.auth().currentUser != nil{
            DataService.ds.REF_CLUBS.addSnapshotListener { (querySnapshot, error) in
                guard let postChanges = querySnapshot else{
                    print("Error fetching document: \(error!)")
                    return
                }
                postChanges.documentChanges.forEach({ (diff) in
                    if diff.type == .added || diff.type == .modified || diff.type == .removed{
//                        let documentID = diff.document.documentID
                        let clubName = diff.document.data()["Club Name"] as? String
                        let url = diff.document.data()["Url"] as? String
                        let post = Clubs(clubName: clubName!, categories: nil, imageUrl: url)
                        completionBlock(post, nil)
                        
                    }
                })
                
            }
            
        }else{
            let errorMessage = "Data fecth error: user could not be authenitcated."
            completionBlock(nil, errorMessage)
        }

    }
    
}

