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

class ProfileView: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    

    var userProfile = [User]()
    var userClubs = [String]()

    let uid = Auth.auth().currentUser?.uid
    
    let imagePicker = UIImagePickerController()

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var userGrade: UILabel!
    @IBOutlet weak var clubList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        clubList.delegate = self
        clubList.dataSource = self
        clubList.reloadData()
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        navigationController?.delegate = self
        
        profileImage.layer.borderWidth = 0.5
        profileImage.layer.borderColor = UIColor.darkGray.cgColor
        profileImage.layer.masksToBounds = false
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        profileImage.clipsToBounds = true

        // Do any additional setup after loading the view.
    }
    
    @IBAction func unwindToVC1(segue:UIStoryboardSegue) { }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userClubs.count
        
    }
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = clubList.dequeueReusableCell(withIdentifier: "clubCell", for: indexPath) as! ClubListCell
//        let club = user[indexPath.row]
//        cell.clubName.text = club
//        cell.clubProfileImage.downloadImageFrom(urlString: club.)
//        cell.clubName.sizeToFit()
////        cell.clubProfileImage.downloadImageFrom(urlString: imageUrl!)
//
//
//        return cell
//    }
//
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = clubList.dequeueReusableCell(withIdentifier: "clubCell", for: indexPath) as! ClubListCell
//        let user = userProfile[indexPath.row]
        let listClubs = userClubs[indexPath.row]
        
        cell.clubName.text = listClubs
        cell.clubName.sizeToFit()
        
        return cell
        
    }
    
//    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//
//        if editingStyle == .delete{
//            list.remove(at: indexPath.row)
//            clubList.beginUpdates()
//            clubList.deleteRows(at: [indexPath], with: .fade)
//
//
//        }
//    }
    
    

    
//    func fetchUserClubs(userID: String){
//        User.fetchUserData(userID) { (userData, error) in
//            if error != nil{
//                print(error!)
//            }else{
//                if let clubs = userData?.clubs{
//                    for club in clubs{
//                        self.list.append(club)
//                    }
//
//                    DispatchQueue.main.async {
//                        self.clubList.reloadData()
//                    }
//                    return
//                }
//            }
//        }
//
//    }
    
    
    @IBAction func logOutButtonPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
//            performSegue(withIdentifier: "goToLoginFromProfileView", sender: self)
        }
        catch {
            print("Error signing out")
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            
            profileImage.contentMode = .scaleAspectFit
            profileImage.image  = pickedImage
            
            FireStorageImageUpload().uploadImage(pickedImage, progressBlock: {_ in}, completionBlock: { (url, error) in
                if error != nil{
                    print(error!)
                }else{
                    let imageUrl = url?.absoluteString
                    DataService.ds.REF_USERS.document(self.uid!).updateData(["Url" : imageUrl!], completion: { (error) in
                        if error != nil{
                            print(error!)
                        }else{
                            print("Successfully updated profile image")
                        }
                    })
                }
            })
            
        }
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func changePictureButtonPressed(_ sender: UIButton) {
        present(imagePicker, animated: true, completion: nil)
        
    
    }
    
//    func showUserProfile(){
//        User.fetchUserData(uid!, completionBlock: { (user, error) in
//            if let profileImage = user?.profileUrl{
//                self.profileImage.downloadImageFrom(urlString: profileImage)
//            }
//            self.profileName.text = user?.name
//            self.userGrade.text = user?.grade
//        })
//
//
//    }
    
    func showUserProfile(userID: String?){
        User.fetchUserData(userID!, completionBlock: { (user, error) in
            self.userProfile.append(user!)
            if let profileImage = user?.profileUrl{
                self.profileImage.downloadImageFrom(urlString: profileImage)
            }
            self.profileName.text = user?.name
            self.userGrade.text = user?.grade
            if let clubs = user?.clubs{
                for club in clubs{
                    self.userClubs.append(club)
                }
                
            }
            DispatchQueue.main.async {
                self.clubList.reloadData()
            }
            return

        })
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        showUserProfile(userID: uid!)
        userClubs = []

    }


    

    
    
}
