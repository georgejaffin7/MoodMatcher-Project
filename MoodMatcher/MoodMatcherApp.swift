//
//  MoodMatcherApp.swift
//  MoodMatcher
//
//  Created by George Jaffin on 11/17/24.
//

import SwiftUI
import FirebaseCore // <-- Import Firebase

@main
struct MoodMatcherApp: App {

    @State private var authManager: AuthManager // <-- Create a state managed authManager property

    init() {
        FirebaseApp.configure()
        authManager = AuthManager() // <-- Initialize the authManager property (needs to be done after FirebaseApp.configure())
    }

    var body: some Scene {
        WindowGroup {
            if authManager.user != nil { // <-- Check if you have a non-nil user (means there is a logged in user)

                // We have a logged in user, go to ChatView
                NavigationStack {
                    MoodGridView()
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem {
                                Button("Sign out") {
                                    authManager.signOut()
                                }
                            }
                        }
                }
            } else {

                // No logged in user, go to LoginView
                LoginView()
                    .environment(authManager)
            }
        }
    }
}
