//
//  ViewController.swift
//  LiftingLog
//
//  Created by Neil Kalanish on 9/22/22.
//
// TODO:
// 1) Wire up the Ui to actually save the workout when the user types in the workout values
// 2) Figure out how we want to read the data from the DB and make it usable
import UIKit
import AuthenticationServices

class ViewController: UIViewController {

    @IBOutlet var userNameLogin: UITextField!
    @IBOutlet weak var passwordLogin: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var createAccButton: UIButton!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        title = "Welcome to Lifting Log!"
        navigationItem.setHidesBackButton(true, animated: true)
        setupAppleSignInButton()
    }

    private func setupAppleSignInButton() 
    {
        let appleButton = ASAuthorizationAppleIDButton()
        appleButton.addTarget(self, action: #selector(handleAppleIDRequest), for: .touchUpInside)

        // Set the frame or use Auto Layout constraints
        appleButton.frame = CGRect(x: 40, y: 400, width: view.frame.width - 80, height: 50) // Adjust as needed
        view.addSubview(appleButton)
    }

    @objc func handleAppleIDRequest() 
    {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]

        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }

    @IBAction func logInClicked(_ sender: UIButton) 
    {
        self.navigateToMainDash()
    }
}

extension ViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding
{
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            // Handle successful authorization
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            self.navigateToMainDash()

        }
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error)
    {
        // Handle error here
        print("Error with Apple ID Authorization: \(error.localizedDescription)")
    }

    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor
    {
        return self.view.window!
    }
}
