//
//  Post.swift
//  ClubHub
//
//  Created by Gianmaria Biselli on 1/27/18.
//  Copyright © 2018 Gianmaria Biselli. All rights reserved.
//

import Foundation

class Post {
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
    
}
