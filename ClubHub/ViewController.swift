//
//  ViewController.swift
//  ClubHub
//
//  Created by Gianmaria Biselli on 1/26/18.
//  Copyright © 2018 Gianmaria Biselli. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func signInButtonPressed(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: emailField.text!, password: password.text!, completion: { (user, error) in
            if error != nil{
                print(error!)
            }else{
                self.performSegue(withIdentifier: "fromLoginViewToHomeFeed", sender: self)
                print("Succesfully signed in")
            }
        })
        
    }
    
    


}

