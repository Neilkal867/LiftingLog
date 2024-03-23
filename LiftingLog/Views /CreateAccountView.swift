//
//  CreateAccountView.swift
//  LiftingLog
//
//  Created by Joseph Melito on 3/6/24.
//

import SwiftUI

struct CreateAccountView: View {
    // State variables to hold the input text values
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var userEmail: String = ""
    @State private var password: String = ""
    @State private var dateOfBirth = Date()
    
    
    @State private var isCancel = false
    @State private var showAlert = false
    @State private var showFillOutAlert = false
    @State private var isDatePickerPresented = false
    @State private var isNewUser = false
    @State private var invalidEmailOrInUse = false
    
    let authService = AuthenticationService()
    
    var body: some View {
        if isCancel
        {
            LoginView()
        }
        else if isNewUser
        {
            UserProfileCreationView()
        }
        else
        {
            createAccForm
        }
    }
    
    var createAccForm: some View {
        NavigationView{
            Form {
                TextField("First Name", text: $firstName)
                TextField("Last Name", text: $lastName)
                TextField("Email", text: $userEmail)
                SecureField("Password (6 Character Min)", text: $password)
                DatePicker("Date of Birth", selection: $dateOfBirth, displayedComponents: .date)
                    .datePickerStyle(CompactDatePickerStyle())
                
                Button("Create Account") {
                    createAccountClicked()
                }
                .alert(isPresented: $showFillOutAlert) { // New alert for missing information
                    Alert(
                        title: Text("Missing Information"),
                        message: Text("Please fill out all fields to create an account."),
                        dismissButton: .default(Text("OK"))
                    )
                }
                //.alert(isPresented: $invalidEmailOrInUse) { // New alert for missing information
                   // Alert(
                 //       title: Text("Invalid Input"),
             //           message: Text("Please Use A Different Email. Also Please Make Sure Your Password Is At Least 6 Characters Long."),
               //         dismissButton: .default(Text("OK"))
                 //   )
               // }
            }
        
        .navigationBarTitle("Account Creation")
        .navigationBarItems(leading: Button("Cancel") {
            self.showAlert = true
        })}
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Confirmation"),
                    message: Text("Are you sure you want to cancel?"),
                    primaryButton: .destructive(Text("Yes")) {
                        self.isCancel = true
                        print("Cancelled.")
                        // Logic to handle cancellation here
                    },
                    secondaryButton: .cancel()
                )
            }
        
    }
    
    func createAccountClicked()
    {
        // Implement account creation logic here
        print(firstName, lastName, userEmail, password, dateOfBirth)
        if (!userEmail.isEmpty && !password.isEmpty)
        {
            authService.createUser(emailAddress: userEmail, password: password) { authresponse in
                if(authresponse.SuccesfulSignin)
                {
                    GlobalManager.shared.userID = authService.getCurrentUser()
                    GlobalManager.shared.newUserEmail = userEmail
                    self.isNewUser = true
                }
                else
                {
                    self.invalidEmailOrInUse = true
                }
            }
        }
        else {
            self.showFillOutAlert = true
        }
    }
}

struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView()
    }
}
