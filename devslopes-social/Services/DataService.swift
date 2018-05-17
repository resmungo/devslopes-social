//
//  DataService.swift
//  devslopes-social
//
//  Created by Allan Edwards on 5/7/18.
//  Copyright © 2018 Allan Edwards. All rights reserved.
//

import Foundation
import Firebase
import SwiftKeychainWrapper


let DB_BASE = Database.database().reference()
let STORAGE_BASE = Storage.storage().reference()



class DataService {
    static let ds = DataService()
    
    private var _REF_BASE = DB_BASE
    private var _REF_POSTS = DB_BASE.child("posts")
    private var _REF_USERS = DB_BASE.child("users")
    
    private var _REF_POST_IMAGES = STORAGE_BASE.child("post-pics")
    
    
    var REF_BASE: DatabaseReference! {
        return _REF_BASE
    }
    var REF_POSTS: DatabaseReference! {
        return _REF_POSTS
    }
    var REF_USERS: DatabaseReference {
        return _REF_USERS
    }
    var REF_USER_CURRENT: DatabaseReference {
        let uid = KeychainWrapper.standard.string(forKey: KEY_UID)
        let user = REF_USERS.child(uid!)
        return user
        
    }
    
    
    var REF_POST_IMAGES: StorageReference {
        return _REF_POST_IMAGES
    }
    
    
    
    
    func createFirebaseDBUser(uid: String, userData: Dictionary<String, String>) {
        REF_USERS.child(uid).updateChildValues(userData)
    }
    
    
    
}
