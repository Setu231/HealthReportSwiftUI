//
//  HRLoginView.swift
//  HealthReportSwiftUI
//
//  Created by Setu Desai on 2/12/24.
//

import SwiftUI

struct HRLoginView: View {
    
    @StateObject var hrLoginViewModel = HRLoginVM()
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Login")
                .foregroundLinearGradient(colors: [.pink, .purple], startPoint: .leading, endPoint: .trailing)
                .fontWeight(.heavy)
                .font(.largeTitle)
                .frame(maxWidth: .infinity)
            Spacer().frame(maxHeight: 60)
            TextField("Username", text: $hrLoginViewModel.usernameTextfield)
                .textFieldStyle(.automatic)
            Spacer().frame(maxHeight: 40)
            TextField("Password", text: $hrLoginViewModel.passwordTextField)
            Spacer().frame(maxHeight: 60)
            Button(action: {
                hrLoginViewModel.loginAccount()
            }, label: {
                Text("Log In")
                    .fontWeight(.heavy)
                    .font(.title3)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(LinearGradient(gradient: Gradient(colors: [.pink, .purple]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(40)
            })
            .navigationDestination(isPresented: hrLoginViewModel.isLoginReady) {
                HRHealthDataView()
            }
            HStack {
                NavigationLink(destination: HRSignupView()) {
                    Text("Sign In")
                        .foregroundLinearGradient(colors: [.pink, .purple], startPoint: .leading, endPoint: .trailing)
                }
                Spacer()
            }.padding(10)
        }
        .padding(20)
        .alert(isPresented: $hrLoginViewModel.isAlertRequired) {
            Alert(title: Text(hrLoginViewModel.alertItem.title),
                  message: Text(hrLoginViewModel.alertItem.message),
                  dismissButton: .default(Text("Ok")))
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    HRLoginView()
}
