//
//  ResetPasswordView.swift
//  LiftingLog
//
//  Created by Joseph Melito on 3/6/24.
//

import SwiftUI


// SwiftUI view for resetting password
struct ResetPasswordView: View {
    @State private var email: String = ""
    @State private var showAlert: Bool = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
   
    @State private var isEmailPresent = false
    @State private var returnToWelcome = false
   
    var body: some View {
            if returnToWelcome{
                LoginView()
            } else {
                resetPasswordForm
            }
        }
    var resetPasswordForm: some View {
        NavigationView {
            VStack {
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button("Submit") {
                                if email.isEmpty {
                                    alertTitle = "Missing Information"
                                    alertMessage = "Please Enter Your Email Address."
                                } else {
                                    alertTitle = "Success"
                                    alertMessage = "Email submitted successfully."
                                    self.isEmailPresent = true
                                    
                                    
                                }
                                showAlert = true
                                
                            }
                            .alert(isPresented: $showAlert) {
                                Alert(title: Text(alertTitle),
                                      message: Text(alertMessage),
                                      dismissButton: .default(Text("OK"),action: {
                                    if self.isEmailPresent{
                                        self.returnToWelcome = true
                                    }
                                }))
                            }
                        }
                        .padding()
                        .navigationTitle("Reset Password")
                        .navigationBarItems(leading: Button("Cancel") {
                                        self.returnToWelcome = true
                                    })
        }
    }
    
}

// Entry point for the SwiftUI app or a specific view, depending on your app structure
struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
    }
}
