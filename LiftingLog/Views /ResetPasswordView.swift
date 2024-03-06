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
   
    @State private var isEmailBlank = false
    @State private var isEmailPresent = false
    
    var body: some View {
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
                                }
                                showAlert = true
                            }
                            .alert(isPresented: $showAlert) {
                                Alert(title: Text(alertTitle),
                                      message: Text(alertMessage),
                                      dismissButton: .default(Text("OK")))
                            }
                        }
                        .padding()
                        .navigationTitle("Reset Password")
        }
    }
    
    func resetAccountPassword() {
        print(email)
        if !email.isEmpty{
                self.isEmailBlank = false
            }
            else {
                self.isEmailPresent = true
            }
        }
}

// Entry point for the SwiftUI app or a specific view, depending on your app structure
struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
    }
}
