//
//  SignUpOneView.swift
//  ClubHub
//
//  Created by Gianmaria Biselli on 1/31/18.
//  Copyright © 2018 Gianmaria Biselli. All rights reserved.
//

import UIKit

class SignUpOneView: UIViewController {

    @IBOutlet weak var clubButton: UIButton!
    @IBOutlet weak var personalButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func clubButtonPressed(_ sender: UIButton) {
        let signUpViewTwo = storyboard?.instantiateViewController(withIdentifier: "SignUpViewTwo") as! SignUpView
        signUpViewTwo.club = true
        present(signUpViewTwo, animated: true, completion: nil)
    }
    

    

    

}
