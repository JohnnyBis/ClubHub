//
//  HomeFeedView.swift
//  ClubHub
//
//  Created by Gianmaria Biselli on 1/27/18.
//  Copyright © 2018 Gianmaria Biselli. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseAuth

class HomeFeedView: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var clubPosts: UITableView!
    var postList = [Post]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchData(){
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
                        let url = diff.document.data()["Image Url"] as? String
                        let post = Post(postBody: postBody, title: title, url: url, likes: likes, documentID: documentID, userName: userName)
                        self.postList.append(post)
//                          DispatchQueue.main.async(execute: {
//                              self.resultMenu.reloadData()
//                           })
                        
                    
                        print(self.postList)
                    }
                })
                
            }
            
        }else{
            print("Data fecth error: user could not be authenitcated.")
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return postList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
    
    
    
}
