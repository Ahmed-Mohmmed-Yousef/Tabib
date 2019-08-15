//
//  LoginController.swift
//  TabibDoctor
//
//  Created by Ahmed on 7/13/19.
//  Copyright © 2019 Refaq, ORG. All rights reserved.
//

import Foundation
import Firebase
import GoogleSignIn

class AuthController{
    
    static func login(_ email: String, _ password: String, completion: @escaping(Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            if error != nil {
                completion(error)
                return
            }
            completion(nil)
        }
    }
    static func logout(completion: @escaping(Bool?) -> Void){
        do {
            logOutFromSocial()
            try Auth.auth().signOut()
            completion(true)
        } catch {
            completion(false)
        }
        
    }
    static func loginWithGoogle(){
        GIDSignIn.sharedInstance().signIn() 
    }
    static func loginWithPhone(){
        
    }
    
    // logout
    static func logOutFromSocial(){
        guard let user = Auth.auth().currentUser else { return }
        for info in (user.providerData){
            if info.providerID == "GoogleAuthProvider" {
                GIDSignIn.sharedInstance()?.signOut()
            }
        }
    }
}
