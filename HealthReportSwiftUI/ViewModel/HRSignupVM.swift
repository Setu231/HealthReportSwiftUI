//
//  HRSignupVM.swift
//  HealthReportSwiftUI
//
//  Created by Setu Desai on 2/12/24.
//

import FirebaseAuth

final class HRSignupVM: ObservableObject {
    
    @Published var usernameTextfield = ""
    @Published var passwordTextField = ""
    @Published var confirmPasswordTextField = ""
    
    func signUp() {
        if !usernameTextfield.isEmpty, !passwordTextField.isEmpty {
            Auth.auth().createUser(withEmail: usernameTextfield, password: passwordTextField) { result, error in
                if error != nil {
                    print(error?.localizedDescription ?? "")
                }
            }
        }
    }
}

