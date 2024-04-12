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
    @State private var userEmail: String?
    @State private var isNewUser = false
    //@State private var isNoAcc = false
    @State private var isPWForgot = false
    @State private var noEmailOrPassword = false
    let dbService = DatabaseService()
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        if appState.isLoggedIn {
            WelcomeDashboardView()
        }
        else if isNewUser{
            UserProfileCreationView()
        }
        else if appState.isNoAcc{
            CreateAccountView()
        }
        else if isPWForgot{
            ResetPasswordView()
        }
        else {
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
                            GlobalManager.shared.newUserEmail = appleIDCredential.email
                            GlobalManager.shared.userID = appleIDCredential.user
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
            .alert(isPresented: $noEmailOrPassword) {
                Alert(title: Text("Credentials Not Found"),
                      message: Text("Please Enter a Valid Username and Password"),
                      dismissButton: .default(Text("OK"),action: {
                }))
            }
            Text("Forgot Password?")
                .foregroundColor(.blue) // Hyperlink color
                .onTapGesture {
                    self.isPWForgot = true
                }
                .padding()
            
            HStack(spacing: 0) {
                Text("Don't Have An Account? ")
                    .foregroundColor(.primary)
                
                Text("Create One.")
                    .foregroundColor(.blue)
                    .onTapGesture {
                        appState.isNoAcc = true
                        //self.isNoAcc = true
                        print("Tapped Create One.")
                    }
            }
            
        }
        .onAppear {
                    // Reset text fields if the user is not logged in
                     
                        self.userName = ""
                        self.password = ""
                    }
        
        .navigationTitle("Login")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
    
    
    func login()
    {
       
        // If the username and password is filled in the user is attempting to log in with the auth service.
        if (!userName.isEmpty && !password.isEmpty)
        {
           // authService.getCurrentUser()
            firebaseAuth(emailAddress: userName, password: password)
            return;
        }
        
        //This is a new user because the userEmail is NOT nil.  We want to store the userID and email together
        if (GlobalManager.shared.newUserEmail != nil)
        {
            self.isNewUser = true
            return;
        }
        
        //This is a user who has logged in before
        if (GlobalManager.shared.newUserEmail == nil && GlobalManager.shared.userID != nil )
        {
            loadProfileAndWorkoutsBeforLogin(userId: GlobalManager.shared.userID!)
            appState.isLoggedIn = true // Set this to true when login is successful
            return;
        }

        if (userName.isEmpty || password.isEmpty)
                {
                    noEmailOrPassword = true
                    return;
                }
    }

    
    private func createAccount() {
        // Implement the reset password functionality
    }
    
    func firebaseAuth(emailAddress: String, password: String)
    {
        let authService = AuthenticationService()
        authService.logUserIn(emailAddress: emailAddress, password: password) { Authresponse in
    
            //The user's credientials are valid so we log them in
            if(Authresponse.SuccesfulSignin)
            {
                let userID = authService.getCurrentUser()
                GlobalManager.shared.userID = userID
                loadProfileAndWorkoutsBeforLogin(userId: userID)
                appState.isLoggedIn = true
            }
            
            //The user's credientials are invalid so we don't log them in.  Maybe we display this error as a prompt
            if(!Authresponse.SuccesfulSignin)
            {
                print(Authresponse.Error.description)
                noEmailOrPassword = true
                
            }
        }
    }
    
    func loadProfileAndWorkoutsBeforLogin(userId: String)
    {
        dbService.loadUserProfile(userID: userId)
        //dbService.loadUserProfile(userID: GlobalManager.shared.userID!)
        DatabaseService.loadWorkouts()
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
}
