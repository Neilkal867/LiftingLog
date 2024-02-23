//
//  LoginView.swift
//  LiftingLog
//
//  Created by Joseph Melito on 2/19/24.
//

import SwiftUI
import AuthenticationServices

var userID: String?

struct LoginView: View {
    @State private var userName: String = ""
    @State private var password: String = ""
    @State private var userEmail: String?
    @State private var isAuthenticated = false // Declare the state variable for authentication status
    @State private var isNewUser = false
    let dbService = DatabaseService()
    
    var body: some View {
        if isAuthenticated {
            WelcomeDashboardView()
        } 
        else if isNewUser{
            UserProfileCreationView()
        }
        else {
            loginForm
            //LoginView()
        }
    }
    
    var loginForm: some View {
        VStack {
            Text("Welcome to Pump Path!")
                .font(.largeTitle)
                .padding()
                .buttonStyle(.bordered)
            
            SignInWithAppleButton(
                onRequest: { request in
                    // Configure the request here.
                },
                onCompletion: { [self] result in // Added [self] to capture list
                    switch result {
                    case .success(let authResults):
                        switch authResults.credential {
                        case let appleIDCredential as ASAuthorizationAppleIDCredential:
                            self.userEmail = appleIDCredential.email
                            GlobalManager.shared.newUserEmail = self.userEmail ?? "No Email Found"
                            userID = appleIDCredential.user
                            login()
                        default:
                            break
                        }
                    case .failure(let error):
                        // Handle error
                        print(error)
                    }
                }
            )
            
            .frame(height: 50)
            .signInWithAppleButtonStyle(.whiteOutline)
            .padding()
            
            
            HStack {
                Line() // Custom Line view
                    .frame(height: 1)
                Text("OR")
                    .foregroundColor(.primary)
                    .padding(.horizontal, 5)
                Line() // Custom Line view
                    .frame(height: 1)
            }
            .padding()
            
            TextField("Username", text: $userName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Log In") {
                self.login() // Corrected the function name to match the definition
            }
            .buttonStyle(.borderedProminent)
            .padding()
            .frame(width: 380, height: 50)
            
            Text("Forgot Password?")
                .foregroundColor(.blue) // Hyperlink color
                .onTapGesture {
                    resetPassword()
                }
                .padding()
            
            HStack(spacing: 0) {
                Text("Don't Have An Account? ")
                    .foregroundColor(.primary)
                
                Text("Create One.")
                    .foregroundColor(.blue)
                    .onTapGesture {
                        // Call your function here
                        print("Tapped Create One.")
                    }
            }
            
        }
        
        .navigationTitle("Login")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
    
    
    func login() {
        // Perform login logic here
       
        
        //This is a new user because the userEmail is NOT nil.  We want to store the userID and email together
        if (self.userEmail != nil)
        {
            self.isNewUser = true
            return;
        }
        
        //This is a user who has logged in before
        if (self.userEmail == nil && userID != nil)
        {
           // this is for testing --->  self.isNewUser = true
            self.isAuthenticated = true // Set this to true when login is successful
            return; 
        }
        
            self.isAuthenticated = true // Set this to true when login is successful
       //this is also for testing ----> self.isNewUser = true
    }
    private func resetPassword() {
        // Implement the reset password functionality
    }
    
    private func createAccount() {
        // Implement the reset password functionality
    }
    
}
    
    struct Line: View {
        var body: some View {
            Rectangle()
                .fill(Color.secondary) // Set the color of the line here
        }
    }
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            LoginView()
        }
    }

