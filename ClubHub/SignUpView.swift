//
//  SignUpView.swift
//  ClubHub
//
//  Created by Gianmaria Biselli on 1/27/18.
//  Copyright © 2018 Gianmaria Biselli. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpView: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    var userDict: [String:Any] = [:]
    var club = false

    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var addImageButton: UIButton!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var gradeField: UITextField!
    @IBOutlet weak var error: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    
    let imagePicker = UIImagePickerController()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        error.isHidden = true
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        signUpButton.isHidden = false
        showClubField(club: club)
        print(club)

        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addPictureButtonPressed(_ sender: UIButton) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        
        if nameField.text?.isEmpty ?? true {
            error.text = "Please insert your name"
            error.isHidden = false
            
        }else if emailField.text?.isEmpty ?? true{
            error.text = "Please insert your email"
            error.isHidden = false
            
        }else if passwordField.text?.isEmpty ?? true{
            error.text = "Please insert your password"
            error.isHidden = false
            
        }else if gradeField.text?.isEmpty ?? true{
            error.text = "Please insert your grade"
            error.isHidden = false
            
        }else{
            createUserData()
            print(userDict)
            creatDBUser(userData: userDict)
            print("Successful registration")
        }
    }
    
    
    func creatDBUser(userData: Dictionary<String, Any>){
        Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!, completion: { (user, error) in
            if error != nil{
                print(error!)
                let errorMessage = error?.localizedDescription
                self.error.text = errorMessage
                self.error.sizeToFit()
                
            }else{
                DataService.ds.createFirebaseDBUsers(uid: (user?.uid)!, userData: userData)
                print("Successful registration")
                self.performSegue(withIdentifier: "fromSignUpToHomeFeed", sender: self)
                
            }
        })
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            profileImage.contentMode = .scaleAspectFit
            profileImage.image = pickedImage
            
            FireStorageImageUpload().uploadImage(pickedImage, progressBlock: { (percentage) in
                let percentage = percentage
                print(percentage)
            }, completionBlock: { (url, error) in
                if error != nil{
                    print(error!)
                }else{
                    self.userDict["Url"] = url?.absoluteString
                    print(url?.absoluteString)
                }
            })
            
        }
        dismiss(animated: true, completion: nil)
        
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func showClubField(club: Bool){
        if club == true{
            nameField.placeholder = "Club Name"
            return
        }
    }
    
    func createUserData(){
        userDict.updateValue(nameField.text!, forKey: "User Name")
        userDict.updateValue(emailField.text!, forKey: "Email")
        userDict.updateValue(gradeField.text!, forKey: "Grade")
        
        if club == true{
            userDict.updateValue(true, forKey: "Club")
            let club = Clubs(clubName: nameField.text!, categories: ["First", "Second", "Third"], imageUrl: nil)
            let clubData = ["Club name": club.clubName, "Categories": club.categories!] as [String : Any]
            print(clubData)
            DataService.ds.createFirebaseDBClubs(clubData: clubData)
            
        }else{
            userDict.updateValue(false, forKey: "Club")
        }
    }
    

    
    
}


