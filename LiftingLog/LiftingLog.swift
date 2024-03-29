//
//  LiftingLog.swift
//  LiftingLog
//
//  Created by Joseph Melito on 2/19/24.
//
import SwiftUI

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

class AppState: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var isNoAcc: Bool = false
    
    func logout() {
            isLoggedIn = false
            isNoAcc = false 
        }
    
    
}

@main
struct LiftingLog: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var appState = AppState()
    var body: some Scene {
        WindowGroup {
            LoginView()
                .environmentObject(appState) // Attach AppState to the environment
                        
        }
        
    }
}
