//
//  addPostView.swift
//  ClubHub
//
//  Created by Gianmaria Biselli on 2/1/18.
//  Copyright © 2018 Gianmaria Biselli. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class addPostView: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate{
    
    var userDict: [String:Any] = [:]
    let uid = Auth.auth().currentUser?.uid
    
    let imagePicker = UIImagePickerController()
    @IBOutlet weak var postBody: UITextView!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var addPictureButton: UIButton!
    @IBOutlet weak var postButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        postBody.delegate = self
        addUserName()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            
            postImage.contentMode = .scaleAspectFit
            postImage.image  = pickedImage
            addPictureButton.isHidden = true
            
            
            FireStorageImageUpload().uploadImage(pickedImage, progressBlock: { (percentage) in
                let percentage = percentage
                self.progressBar.setProgress(Float(percentage), animated: true)
                if percentage < 100.0 {
                    self.postButton.isHidden = true
                    
                }else{
                    self.postButton.isHidden = false
                }
                
                print(percentage)
            }, completionBlock: { (url, error) in
                if error != nil{
                    print(error!)
                }else{
//                    let url = Post(url: url)
                    self.userDict["Url"] = url?.absoluteString
                    
                }
            })
            
        }
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func postButtonPressed(_ sender: UIButton) {
        let timestamp = FieldValue.serverTimestamp()
        self.userDict["Last update"] = timestamp
        self.userDict["Body"] = postBody.text
        print(userDict)
        addPostToFirebaseDB(userData: userDict)
        
    }

    
    @IBAction func addPictureButtonPressed(_ sender: UIButton) {
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func addPostToFirebaseDB(userData: Dictionary<String, Any>){
        DataService.ds.createFirebaseDBPosts(userData: userData)
    }
    
    func addUserName(){
        User.fetchUserPostData(uid!) { (user, error) in
            if error != nil{
                print(error!)
            }else{
                self.userDict["User Name"] = user?.name
            }
        }
    }
 
}
