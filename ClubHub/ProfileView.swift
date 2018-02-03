//
//  ProfileView.swift
//  ClubHub
//
//  Created by Gianmaria Biselli on 1/29/18.
//  Copyright © 2018 Gianmaria Biselli. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage

class ProfileView: UIViewController{

    
    var list = [Post]()

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var userGrade: UILabel!
    @IBOutlet weak var clubList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let userID = Auth.auth().currentUser?.uid{
            fetchUser(userID: userID)
            fetchUserClubs(userID: userID)
            return
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchUser(userID: String){
        User.fetchUserData(userID, completionBlock: { (userName, userEmail, userGrade, imageUrl, club, error) in
            if error != nil{
                print(error!)
                
            }else{
                
                self.profileName.text = userName
                self.userGrade.text = "Grade: \(userGrade)"
                self.profileName.sizeToFit()
                self.userGrade.sizeToFit()
                
                if let url = imageUrl{
                    let storageRef = Storage.storage().reference(forURL: url)
                    storageRef.downloadURL(completion: { (url, error) in
                        if error != nil{
                            print(error!)
                            return
                        }
                        let data = NSData(contentsOf: url!)
                        let image = UIImage(data: data! as Data)
                        self.profileImage.image = image
                    })
    
                }
                
                
            }

        })
        
    }
    
    func fetchUserClubs(userID: String){
        User.fetchUserClubs(userID) { (clubs, error) in
            if error != nil{
                print(error!)
            }else{
                for club in clubs!{
                    print(club)
//                    list.append(club)
//                    print(self.list)
                    
                    
                }
                
            }
        }
    }
    
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
//
//
    
    
    
    
    

}
