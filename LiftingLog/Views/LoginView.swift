//
//  LoginView.swift
//  LiftingLog
//
//  Created by Joseph Melito on 2/19/24.
//

import SwiftUI
import AuthenticationServices

struct LoginView: View {
    @State private var userName: String = ""
    @State private var password: String = ""
    @State private var isAuthenticated = false // Declare the state variable for authentication status

    var body: some View {
            if isAuthenticated {
                WelcomeDashboardView()
            } else {
                loginForm
            }
        }
    
    var loginForm: some View {
            VStack {
                Text("Welcome to Pump Path!")
                    .font(.largeTitle)
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
                
                Button("Create Account") {
                    // Placeholder for account creation
                }
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
                                // Handle success
                                self.isAuthenticated = true
                            default:
                                break
                            }
                        case .failure(let error):
                            // Handle error
                            print(error)
                        }
                    }
                )
                .signInWithAppleButtonStyle(.black)
                .frame(height: 50)
                .padding()
                                
                Text("Reset Password")
                    .foregroundColor(.blue) // Hyperlink color
                    .underline()
                    .onTapGesture {
                        resetPassword()
                    }
                    .padding()
            }
            .navigationTitle("Login")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
    
    
    func login() {
        // Perform login logic here
        self.isAuthenticated = true // Set this to true when login is successful
    }
    
    private func resetPassword() {
        // Implement the reset password functionality
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
