//
//  Post.swift
//  ClubHub
//
//  Created by Gianmaria Biselli on 1/27/18.
//  Copyright © 2018 Gianmaria Biselli. All rights reserved.
//

import Foundation
import FirebaseAuth
import Firebase

struct Post {
    var imageUrl: String?
    var userName: String?
    var postBody: String?
    var postTitle: String?
    var documentID: String?
    var likes: Int?
    
    
    init(postBody: String?, title: String?, url: String?, likes: Int?, documentID: String?, userName: String?) {
        self.imageUrl = url
        self.userName = userName
        self.postBody = postBody
        self.postTitle = title
        self.likes = likes
        self.documentID = documentID

    }
    
    init(url: URL?){
        self.imageUrl = url?.absoluteString
    }
    
    static func fetchData(_ postList: [Post], completionBlock: @escaping (_ post: Post?, _ error: String?) -> Void){
        if Auth.auth().currentUser != nil{
            DataService.ds.REF_POSTS.addSnapshotListener { (querySnapshot, error) in
                guard let postChanges = querySnapshot else{
                    print("Error fetching document: \(error!)")
                    return
                }
                postChanges.documentChanges.forEach({ (diff) in
                    if diff.type == .added || diff.type == .modified || diff.type == .removed{
                        let documentID = diff.document.documentID
                        let postBody = diff.document.data()["Body"] as? String
                        let title = diff.document.data()["Title"] as? String
                        let likes = diff.document.data()["Likes"] as? Int
                        let userName = diff.document.data()["User Name"] as? String
                        let url = diff.document.data()["Url"] as? String
                        let post = Post(postBody: postBody, title: title, url: url, likes: likes, documentID: documentID, userName: userName)
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
