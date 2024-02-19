//
//  AlertServices.swift
//  LiftingLog
//
//  Created by Joseph Melito on 10/30/22.
//

import Foundation
import UIKit
import SwiftUI
//import FirebaseAuth

extension UIViewController {
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message:
                                                    message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showCancelAlert(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            self.navigationController?.popViewController(animated: true)
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        
        present(alertController, animated: true, completion: nil)
    }
    
    func showSubmissionAlert(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            self.navigateToMainDash()
        }))
        
        present(alertController, animated: true, completion: nil)
    }
    
    
   /* func showDeleteAccountlAlert(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            
            
            // I am about 99% sure this code shouldn't live here....
            let user = Auth.auth().currentUser
            if Auth.auth().currentUser != nil
            {
                user?.delete { error in
                    if error != nil
                    {
                        self.showAlert(title: "Error deleting account", message: error!.localizedDescription)
                    }
                    else
                    {
                        self.showAlert(title: "Account deleted", message: "You have successfully deleted your account")
                    }
                    
                }
            }
            
            
            if let loginView = self.storyboard?.instantiateViewController(withIdentifier: "LoginView") as? UIViewController {
                self.navigationController?.pushViewController(loginView, animated: true)
            }
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        
        present(alertController, animated: true, completion: nil)
    }*/
    
    func navigateToUIKitView<UIVC: UIViewController> (vcToDisplay: String, viewController: UIVC.Type){
        if let displayUIVC = storyboard?.instantiateViewController(withIdentifier: "\(vcToDisplay)") as? UIVC {
            navigationController?.pushViewController(displayUIVC, animated: true)
        }
    }
    
    func navigateToSwiftUIView<Content: View>(_ viewCreator: @escaping () -> Content) {
        // Create the SwiftUI view using the provided closure
        let swiftUIView = viewCreator()
        // Wrap the SwiftUI view in a UIHostingController
        let hostingController = UIHostingController(rootView: swiftUIView)
        // Push the hosting controller onto the navigation stack
        navigationController?.pushViewController(hostingController, animated: true)
    }
    
    func navigateToMainDash(){
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc: UITableViewController = mainStoryboard.instantiateViewController(withIdentifier: "welcomeDash") as! UITableViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func addKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardNotifications(notification:)),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)
    }
    
    func removeKeyboardObserver(){
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    // This method will notify when keyboard appears/ dissapears
    @objc func keyboardNotifications(notification: NSNotification) {
        
        var txtFieldY : CGFloat = 0.0  //Using this we will calculate the selected textFields Y Position
        let spaceBetweenTxtFieldAndKeyboard : CGFloat = 5.0 //Specify the space between textfield and keyboard
        
        
        var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        if let activeTextField = UIResponder.currentFirst() as? UITextField ?? UIResponder.currentFirst() as? UITextView {
            // Here we will get accurate frame of textField which is selected if there are multiple textfields
            frame = self.view.convert(activeTextField.frame, from:activeTextField.superview)
            txtFieldY = frame.origin.y + frame.size.height
        }
        
        if let userInfo = notification.userInfo {
            // here we will get frame of keyBoard (i.e. x, y, width, height)
            let keyBoardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let keyBoardFrameY = keyBoardFrame!.origin.y
            let keyBoardFrameHeight = keyBoardFrame!.size.height
            
            var viewOriginY: CGFloat = 0.0
            //Check keyboards Y position and according to that move view up and down
            if keyBoardFrameY >= UIScreen.main.bounds.size.height {
                viewOriginY = 0.0
            } else {
                // if textfields y is greater than keyboards y then only move View to up
                if txtFieldY >= keyBoardFrameY {
                    
                    viewOriginY = (txtFieldY - keyBoardFrameY) + spaceBetweenTxtFieldAndKeyboard
                    
                    //This condition is just to check viewOriginY should not be greator than keyboard height
                    // if its more than keyboard height then there will be black space on the top of keyboard.
                    if viewOriginY > keyBoardFrameHeight { viewOriginY = keyBoardFrameHeight }
                }
            }
            
            //set the Y position of view
            self.view.frame.origin.y = -viewOriginY
        }
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UIResponder {
    
    static weak var responder: UIResponder?
    
    static func currentFirst() -> UIResponder? {
        responder = nil
        UIApplication.shared.sendAction(#selector(trap), to: nil, from: nil, for: nil)
        return responder
    }
    
    @objc private func trap() {
        UIResponder.responder = self
    }
}

