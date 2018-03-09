//
//  ViewController.swift
//  devslopes-social
//
//  Created by Allan Edwards on 2/5/18.
//  Copyright © 2018 Allan Edwards. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
import Firebase
import SwiftKeychainWrapper




class SignInVC: UIViewController {

    
    @IBOutlet weak var emailField: FancyField!
    @IBOutlet weak var passwordField: FancyField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID) {
            performSegue(withIdentifier: "goToFeed", sender: nil)
            
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func facebookBtnTapped(_ sender: Any) {
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions: [ .publicProfile ], viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                print("Logged in!")
                let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.authenticationToken)
                
                
                self.firebaseAuth(credential)

            }
        }
        

                
                
            }
            
    @IBAction func signinTapped(_ sender: Any) {
        if let email = emailField.text, let pwd = passwordField.text {
            Auth.auth().signIn(withEmail: email, password: pwd, completion: { (user, error) in
                if error == nil {
                    print ("Login success via email")
                    if let user = user {
                        self.completeSignIn(id: user.uid)
                    }
                } else {
                    Auth.auth().createUser(withEmail: email, password: pwd, completion: { (user, error) in
                        if error != nil {
                            print ("Error:User not created with email")
                        } else {
                            print ("User created with email")
                            if let user = user {
                                self.completeSignIn(id: user.uid)
                            }
                            
                        }
                    })
                }
            })
        }
    }

        func firebaseAuth(_ accessToken: AuthCredential) {
            Auth.auth().signIn(with: accessToken, completion: { (user, error) in
                if error != nil {
                    print("Unable to auth with Firebase - \(error)")
                } else {
                    if let user = user {
                        self.completeSignIn(id: user.uid)
                                            }
                    
                    
                    
                    print("Firebase auth success")
                }
            }
                
            )
        }
func completeSignIn(id: String) {
    let keychainResult = KeychainWrapper.standard.set(id, forKey: KEY_UID)
    print("Data saved to keychain: \(keychainResult)" )
    performSegue(withIdentifier: "goToFeed", sender: nil)
    
    
}
}


    


