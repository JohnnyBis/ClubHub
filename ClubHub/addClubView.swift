//
//  addClubView.swift
//  ClubHub
//
//  Created by Gianmaria Biselli on 2/4/18.
//  Copyright © 2018 Gianmaria Biselli. All rights reserved.
//

import UIKit
import FirebaseAuth

class addClubView: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    var clubList = [Clubs]()
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var selectedClub: UILabel!
    var chosenClub: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchClubs(clubs: clubList)
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        selectedClub.sizeToFit()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return clubList.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return clubList[row].clubName
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        chosenClub = clubList[row].clubName
        selectedClub.text = chosenClub
        
    }
    
    func fetchClubs(clubs: [Clubs]){
        Clubs.fetchClubList(clubs) { (clubs, error) in
            if error != nil{
                print(error!)
            }else{
                self.clubList.append(clubs!)
                print(self.clubList)
            }
        }
    }
    
    @IBAction func addClubButtonPressed(_ sender: UIButton) {
        let userID = Auth.auth().currentUser?.uid
        User.addClub(userID: userID, clubName: chosenClub)
        
    }
    


}
