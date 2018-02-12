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

class Post {
    var imageUrl: String?
    var userName: String?
    var postBody: String?
    var postTitle: String?
    var documentID: String?
    var likes: Int?
    var timestamp: String?
    
    
    init(postBody: String?, url: String?, likes: Int?, documentID: String?, userName: String?, timestamp: String?) {
        self.imageUrl = url
        self.userName = userName
        self.postBody = postBody
        self.likes = likes
        self.documentID = documentID
        self.timestamp = timestamp

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
                        let likes = diff.document.data()["Likes"] as? Int
                        let userName = diff.document.data()["User Name"] as? String
                        let url = diff.document.data()["Url"] as? String
                        if let time = diff.document.data()["Last update"] as? NSDate{
                            let formatter = DateFormatter()
                            formatter.dateStyle = .medium
                            formatter.timeStyle = .short
                            let formatTimestamp = formatter.string(from: time as Date)
                            let post = Post(postBody: postBody, url: url, likes: likes, documentID: documentID, userName: userName, timestamp: formatTimestamp)
                            completionBlock(post, nil)
                        }
    
                    }
                })
                
            }
            
        }else{
            let errorMessage = "Data fecth error: user could not be authenitcated."
            completionBlock(nil, errorMessage)
        }
        
    }
    
    static func fetchPosts(_ userID: String, completionBlock: @escaping (_ post: Post?, _ error: String?) -> Void){
        if Auth.auth().currentUser != nil{
            User.fetchUserClubs(userID, completionBlock: { (clubs, error) in
                if error != nil{
                    print(error!)
                }else{
                    for club in clubs!{
                        DataService.ds.REF_POSTS.whereField("User Name", isEqualTo: club).addSnapshotListener({ (querySnapshot, error) in
                            if error != nil{
                                print(error!)
                            }else{
                                querySnapshot?.documentChanges.forEach({ (diff) in
                                    if diff.type == .added || diff.type == .modified || diff.type == .removed{
                                        let documentID = diff.document.documentID
                                        let postBody = diff.document.data()["Body"] as? String
                                        let userName = diff.document.data()["User Name"] as? String
                                        let url = diff.document.data()["Url"] as? String
                                        if let time = diff.document.data()["Last update"] as? NSDate{
                                            let formatter = DateFormatter()
                                            formatter.dateStyle = .medium
                                            formatter.timeStyle = .short
                                            let formatTimestamp = formatter.string(from: time as Date)
                                            let post = Post(postBody: postBody, url: url, likes: nil, documentID: documentID, userName: userName, timestamp: formatTimestamp)
                                            completionBlock(post, nil)
                                        }
                                    }
                                })
                            }
                        })
                    }
                }
            })
            
        }else{
            print("Authentication denied")
        }
    }
    
//    func queryPostFromClub(club: String, completionBlock){
//
//    }
    
}
