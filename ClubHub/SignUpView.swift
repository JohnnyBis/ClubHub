//
//  SignUpView.swift
//  ClubHub
//
//  Created by Gianmaria Biselli on 1/27/18.
//  Copyright © 2018 Gianmaria Biselli. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpView: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var gradeField: UITextField!
    @IBOutlet weak var error: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        error.isHidden = true

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            
            print("Successful registration")
            performSegue(withIdentifier: "fromSignUpToHomeFeed", sender: self)
        }
    }
    
    func creatDBUser(id: String, userData: Dictionary<String, String>){
        DataService.ds.createFirebaseDBUsers(uid: id, userData: userData)
        
    }

    
    
}


