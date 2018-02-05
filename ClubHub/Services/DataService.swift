//
//  DataService.swift
//  ClubHub
//
//  Created by Gianmaria Biselli on 1/27/18.
//  Copyright © 2018 Gianmaria Biselli. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = Firestore.firestore()

class DataService{
    
    static let ds = DataService()
    
    private var _REF_BASE = DB_BASE
    private var _REF_POSTS = DB_BASE.collection("Posts")
    private var _REF_USERS = DB_BASE.collection("Users")
    private var _REF_CLUBS = DB_BASE.collection("Clubs")
    
    var REF_BASE: Firestore{
        return _REF_BASE
    }
    
    var REF_POSTS: CollectionReference{
        return _REF_POSTS
    }
    
    var REF_USERS: CollectionReference{
        return _REF_USERS
    }
    
    var REF_CLUBS: CollectionReference{
        return _REF_CLUBS
    }
    
    
    func createFirebaseDBUsers(uid: String, userData: Dictionary<String, Any>){
        REF_USERS.document(uid).setData(userData) { (error) in
            if error != nil{
                print(error!)
            }else{
                print("Successfully registered user to Firestore database.")
            }
        }
    }
    
    
    func createFirebaseDBPosts(userData: Dictionary<String, Any>){
        REF_POSTS.addDocument(data: userData) { (error) in
            if error != nil{
                print(error!)
            }else{
                print("Successfully registered post to Firestore database")
            }
        }
        
    }
    
    func createFirebaseDBClubs(clubData: Dictionary<String, Any>){
        REF_CLUBS.addDocument(data: clubData) { (error) in
            if error != nil{
                print(error!)
            }else{
                print("Successfully registered club to Firestore database.")
            }
        }
        
        
    }
    
    func addDataFirebaseDBPosts(userData: Dictionary<String, Any>, documentName: String){
        REF_POSTS.document(documentName).updateData(userData) { (error) in
            if error != nil{
                print(error!)
            }else{
                print("Successfully updated post to Firestore database.")
            }
        }
    }
    

    
    
}
