//
//  AlertServices.swift
//  LiftingLog
//
//  Created by Joseph Melito on 10/30/22.
//

import Foundation
import UIKit

extension UIViewController{
    
  func showAlert(title: String, message: String) {
    let alertController = UIAlertController(title: title, message:
      message, preferredStyle: .alert)
    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
    }))
    self.present(alertController, animated: true, completion: nil)
  }
    
    func mainDashUIVC<UIVC: UIViewController> (vcToDisplay: String, viewController: UIVC.Type){
        if let displayUIVC = storyboard?.instantiateViewController(withIdentifier: "\(vcToDisplay)") as? UIVC {
            navigationController?.pushViewController(displayUIVC, animated: true)
            }
        }
}

