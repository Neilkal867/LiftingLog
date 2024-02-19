//
//  LiftingBuddyController.swift
//  LiftingLog
//
//  Created by Joseph Melito on 2/16/24.
//

import UIKit
import SwiftUI

struct ContentView: View{
    var body: some View{
        VStack{
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
                Text()
        }
    }
}


class LiftingBuddyViewController: UITableViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        title = "Lifting Buddy"
    }
    
}
