//
//  ViewController.swift
//  LiftingLog
//
//  Created by Neil Kalanish on 9/22/22.
//

import UIKit
import FirebaseDatabase
import FirebaseFirestore

class ViewController: UIViewController {
    override func viewDidLoad() {
        
        var test12 = "this is a new test"
        var comments = "this is a new comment"
       // ref.childByAutoId().setValue(["name": test12, "comments": comments])
        

        super.viewDidLoad()
        
        test12 = setTitle()
        title = test12
    }
    
    func setTitle()->String{
        
        var test12 = "function"
        let ref = Database.database().reference()
        ref.child("Title/title").getData(completion: {error, snapshot in
         test12 = snapshot?.value as? String ?? "nothing"
    
          
        })
        
        return test12
    }

}

