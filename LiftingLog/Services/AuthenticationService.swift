//
//  AuthenticationService.swift
//  LiftingLog
//
//  Created by Neil Kalanish on 10/27/22.
//

import Foundation
import FirebaseAuth

class AuthenticationService
{
    init(){}
    
    func createUser(emailAddress: String, password: String, completion: @escaping(Authresponse)->())
    {
        
        Auth.auth().createUser(withEmail: emailAddress, password: password) {result, error in
            if error != nil
            {
                completion(Authresponse(SuccesfulSignin: false, Error: error!.localizedDescription))
            }
            
            if result != nil
            {
                completion(Authresponse(SuccesfulSignin: true, Error: "Account successfully created"))
            }
        }
    }
    
    func logUserIn(emailAddress: String, password: String, completion: @escaping(Authresponse) -> ())
    {
        let db = DatabaseService()
        
        Auth.auth().signIn(withEmail: emailAddress, password: password)
        {result, error in
            if error != nil
            {
                completion(Authresponse(SuccesfulSignin: false, Error: error!.localizedDescription))
            }
            
            if result != nil
            {
                //If the user logs in successfully populate the workouts array
                db.intalizeDateArray()
                completion(Authresponse(SuccesfulSignin: true, Error: "Successful login"))
            }
        }
    }
    
    func getCurrentUser() -> String
    {
        let currentUser = Auth.auth().currentUser
        
        if currentUser == nil
        {
            return "nil"
        }
        
        return currentUser!.uid
    }
}


