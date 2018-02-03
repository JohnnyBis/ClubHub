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
        fetchPost()

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
        cell.postBody.text = post.postBody
        cell.likes.text = "\(post.likes)"
        
        if let imageUrl = post.imageUrl{
            cell.postImage.downloadImageFrom(urlString: imageUrl)
            
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 348
    }
    
    func fetchPost(){
        Post.fetchData(postList) { (post, error) in
            if error != nil{
                print(error!)
            }else{
                postList.append(post!)
                DispatchQueue.main.async(execute: {
                    self.posts.reloadData()
                })
            }
        }
    
    }
    
    
    
    
    
}
