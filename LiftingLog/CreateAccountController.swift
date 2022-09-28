//
//  CreateAccountController.swift
//  LiftingLog
//
//  Created by Joseph Melito on 9/27/22.
//

import UIKit

class CreateAccountController: UIViewController {

    @IBOutlet var dateOfBirth: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Account Creation"
        dateOfBirth.contentHorizontalAlignment = .center
        navigationItem.setHidesBackButton(true, animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
