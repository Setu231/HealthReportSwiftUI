//
//  HRLoginVM.swift
//  HealthReportSwiftUI
//
//  Created by Setu Desai on 2/12/24.
//

import SwiftUI
import FirebaseAuth

final class HRLoginVM: ObservableObject {
    
    @Published var isAlertRequired = false
    @Published var alertItem = AlertItem.noError
    @Published var usernameTextfield = ""
    @Published var passwordTextField = ""
    
    var isLoginReady: Binding<Bool> {
        return .constant(alertItem == .noError)
    }
    
    func loginAccount() {
        guard !usernameTextfield.isEmpty, !passwordTextField.isEmpty else {
            UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
            isAlertRequired = true
            alertItem = .emptyDetail
            return
        }
        Auth.auth().signIn(withEmail: usernameTextfield, password: passwordTextField) { result, error in
            guard error == nil else {
                UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
                self.isAlertRequired = true
                self.alertItem = .invalidDetail
                return
            }
            UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
            self.isAlertRequired = false
            self.alertItem = .noError
        }
    }
}
