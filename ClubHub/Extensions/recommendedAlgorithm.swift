//
//  recommendedAlgorithm.swift
//  ClubHub
//
//  Created by Gianmaria Biselli on 1/30/18.
//  Copyright © 2018 Gianmaria Biselli. All rights reserved.
//

import Foundation
import Firebase

class RecommendedEngine{
    
    var grade: String = ""

    func engine(userID: String){
        let firestoreRef = Firestore.firestore().collection("Users").document(userID)
        firestoreRef.addSnapshotListener { (doc, error) in
            if error != nil{
                print(error!)
            }else{
                self.grade = doc?.data()["Grade"] as! String
                
            }
        }
        
    }
    
    
}
