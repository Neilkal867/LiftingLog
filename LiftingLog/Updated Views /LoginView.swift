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
                 
                    .frame(height: 50)
                    .signInWithAppleButtonStyle(.whiteOutline)
                    .padding()
                    
                Text("------------------ OR ------------------")
                                .foregroundColor(.primary)
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
        self.isAuthenticated = true // Set this to true when login is successful
    }
    
    private func resetPassword() {
        // Implement the reset password functionality
    }
    
    private func createAccount() {
        // Implement the reset password functionality
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
