import SwiftUI

struct UserProfileView: View {
    
        @State private var userProfile = UserProfile(email: "", userID: "", sex: "Male", bodyweight: 0, maxBench: 0, maxSquat: 0, maxDeadlift: 0, maxOHP: 0)
        @State private var sex: String = "Male"
        @State private var bodyweight: String = ""
        @State private var maxBench: String = ""
        @State private var maxSquat: String = ""
        @State private var maxDeadlift: String = ""
        @State private var maxOHP: String = ""
        @State private var successfulSubmission = false
        @State private var isLogout = false
    
        let sexOptions = ["Male", "Female"]
        let dbService = DatabaseService()
    
    var body: some View {
            if isLogout {
                LoginView()
            }
            else {
                userProfileForm
            }
        }
    
    var userProfileForm: some View {
        Form {
            Section(header: Text("Personal Information")) {
                Picker("Sex", selection: $userProfile.sex) {
                    ForEach(sexOptions, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())

                HStack {
                    Text("Bodyweight:")
                    Spacer()
                    TextField("lbs.", text: $bodyweight)
                        .keyboardType(.decimalPad)
                        .onAppear {
                            if GlobalManager.shared.userProfile!.bodyweight != 0 {
                                bodyweight = "\(Int(GlobalManager.shared.userProfile!.bodyweight))"
                            }
                        }
                        .onChange(of: bodyweight) { newValue in
                            userProfile.bodyweight = Double(newValue) ?? 0
                        }
                }
            }

            Section(header: Text("Max Lifts (lbs.)")) {
                HStack {
                    Text("Max Bench Press:")
                    Spacer()
                    TextField("lbs.", text: $maxBench)
                        .keyboardType(.numberPad)
                        .onAppear {
                            if GlobalManager.shared.userProfile!.maxBench != 0 {
                                maxBench = "\(Int(GlobalManager.shared.userProfile!.maxBench))"
                            }
                        }
                        .onChange(of: maxBench) { newValue in
                            userProfile.maxBench = Double(newValue) ?? 0
                        }
                }

                HStack {
                    Text("Max Squat:")
                    Spacer()
                    TextField("lbs.", text: $maxSquat)
                        .keyboardType(.numberPad)
                        .onAppear {
                            if GlobalManager.shared.userProfile!.maxSquat != 0 {
                                maxSquat = "\(Int(GlobalManager.shared.userProfile!.maxSquat))"
                            }
                        }
                        .onChange(of: maxSquat) { newValue in
                            userProfile.maxSquat = Double(newValue) ?? 0
                        }
                }

                HStack {
                    Text("Max Deadlift:")
                    Spacer()
                    TextField("lbs.", text: $maxDeadlift)
                        .keyboardType(.numberPad)
                        .onAppear {
                            if GlobalManager.shared.userProfile!.maxDeadlift != 0 {
                                maxDeadlift = "\(Int(GlobalManager.shared.userProfile!.maxDeadlift))"
                            }
                        }
                        .onChange(of: maxDeadlift) { newValue in
                            userProfile.maxDeadlift = Double(newValue) ?? 0
                        }
                }

                HStack {
                    Text("Max Overhead Press:")
                    Spacer()
                    TextField("lbs.", text: $maxOHP)
                        .keyboardType(.numberPad)
                        .onAppear {
                            if GlobalManager.shared.userProfile!.maxOHP != 0 {
                                maxOHP = "\(Int(GlobalManager.shared.userProfile!.maxOHP))"
                            }
                        }
                        .onChange(of: maxOHP) { newValue in
                            userProfile.maxOHP = Double(newValue) ?? 0
                        }
                }
            /*   Button("Submit") {
                    //this button also needs to take the use to the welcome screen
                    if let bodyweightDouble = Double(bodyweight),
                       let maxBenchDouble = Double(maxBench),
                       let maxSquatDouble = Double(maxSquat),
                       let maxDeadliftDouble = Double(maxDeadlift),
                       let maxOHPDouble = Double(maxOHP) {
                        
                        let newUserEmail = GlobalManager.shared.newUserEmail
                        
                        var userprofile = dbService.createUserProfile(email: GlobalManager.shared.newUserEmail ?? "", sex: sex , bodyweight: bodyweightDouble, maxBench: maxBenchDouble, maxSquat: maxSquatDouble, maxDeadlift: maxDeadliftDouble, maxOHP: maxOHPDouble)
                        
                        dbService.createNewUser(profile: userprofile)
                        
                        self.successfulSubmission = true
                        
                    } else {
                        // Handle error: one or more of the inputs are not valid numbers
                        print("Error: One or more inputs are invalid.")
                    }
                }*/
            }
        }
        .navigationTitle("My Profile")
        .navigationBarItems(trailing: Button("Logout"){
            //add logout logic here
            isLogout = true
        })
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}

