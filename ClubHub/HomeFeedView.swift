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

var postList = [Post]()

class HomeFeedView: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var posts: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        posts.delegate = self
        posts.dataSource = self
        self.posts.separatorStyle = .none
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return postList.count

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = posts.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PostCell
        let post = postList[indexPath.row]
        cell.isUserInteractionEnabled = false
        cell.postBody.text = post.postBody
        cell.likes.text = "\(post.likes)"
        cell.timestamp.text = post.timestamp
        
//        if let userID = post.userName {
//            User.fetchUserData(userID, completionBlock: { (userName, userEmail, userGrade, imageUrl, club, error) in
//                cell.profileName.text = userName
//                if let imageUrl = imageUrl {
//                    cell.profileImage.downloadImageFrom(urlString: imageUrl)
//
//                }
//
//            })
//        }
    
        if let imageUrl = post.imageUrl{
            cell.postImage.downloadImageFrom(urlString: imageUrl)
            
        }else{
            posts.rowHeight = 50
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 390
    }
    
//    func fetchPost(){
//        Post.fetchData(postList) { (post, error) in
//            if error != nil{
//                print(error!)
//            }else{
//                postList.append(post!)
//                DispatchQueue.main.async(execute: {
//                    self.posts.reloadData()
//                })
//            }
//        }
//
//    }
    
    func fetchPost(){
        let userID = Auth.auth().currentUser?.uid
        Post.fetchPosts(userID!) { (post, error) in
            if error != nil{
                print(error!)
            }else{
                postList.append(post!)
                DispatchQueue.main.async {
                    self.posts.reloadData()
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchPost()
        postList = []

    }
    
    //    @IBAction func likeButtonPressed(_ sender: UIButton) {
    //        let likes = Post.init(likes: 1)
    //        Post.createLikesDictionary(likes: likes) { (userLikes) in
    //            DataService.ds.addDataFirebaseDBPosts(userData: userLikes, documentName: <#T##String#>)
    //        }
    //
    //    }

    
    
    
    
}
