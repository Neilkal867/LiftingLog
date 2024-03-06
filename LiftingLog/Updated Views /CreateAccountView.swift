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
    @State private var userName: String = ""
    @State private var password: String = ""
    @State private var dateOfBirth = Date()
    
    @State private var isAuthenticated = false
    @State private var isCancel = false
    @State private var isDatePickerPresented = false
    var body: some View {
            if isAuthenticated {
                WelcomeDashboardView()
            }
            else if isCancel{
                UserProfileCreationView()
            }
            else {
                createAccForm
            }
        }
    
    var createAccForm: some View {
        NavigationView {
            Form {
                // First Name Field
                TextField("First Name", text: $firstName)
                
                // Last Name Field
                TextField("Last Name", text: $lastName)
                
                // Username/Email Field
                TextField("Username or Email", text: $userName)
                
                // Password Field
                SecureField("Password", text: $password)
                
                // Date of Birth Picker
                DatePicker("Date of Birth", selection: $dateOfBirth, displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle()) // or CompactDatePickerStyle(), WheelDatePickerStyle() based on preference
                
                // Button to trigger account creation
                Button("Create Account") {
                    createAccountClicked()
                }
            }
            .navigationBarTitle("Account Creation", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                // Implement navigation or action to go back
            }) {
                Text("Cancel")
                    .onTapGesture {
                        self.isCancel = true
                    print("Tapped Create One.")
                }
            })
        }
    }
    
    func createAccountClicked() {
        // Implement account creation logic here
        print(firstName, lastName, userName, password, dateOfBirth)
        
        // Example: Validate and then create user account
        if !userName.isEmpty && !password.isEmpty {
            self.isAuthenticated = true
            // Example call to create user account
        }
    }
    
    // Additional methods can be added here, such as a method for formatting the date
}

struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView()
    }
}
