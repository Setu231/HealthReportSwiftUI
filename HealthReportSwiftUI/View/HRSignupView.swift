//
//  HRSignupView.swift
//  HealthReportSwiftUI
//
//  Created by Setu Desai on 2/12/24.
//

import SwiftUI
import SwiftUI

struct HRSignupView: View {
    
    @StateObject var hrSignupViewViewModel = HRSignupVM()

    var body: some View {
        VStack(alignment: .center) {
            Text("Welcome")
                .foregroundLinearGradient(colors: [.pink, .purple], startPoint: .leading, endPoint: .trailing)
                .fontWeight(.heavy)
                .font(.largeTitle)
                .frame(maxWidth: .infinity)
            Spacer().frame(maxHeight: 60)
            TextField("Username", text: $hrSignupViewViewModel.usernameTextfield)
                .textFieldStyle(.automatic)
            Spacer().frame(maxHeight: 40)
            TextField("Password", text: $hrSignupViewViewModel.passwordTextField)
            Spacer().frame(maxHeight: 40)
            TextField("Confirm Password", text: $hrSignupViewViewModel.confirmPasswordTextField)
            Spacer().frame(maxHeight: 60)
            Button(action: {
                hrSignupViewViewModel.signUp()
            }, label: {
                Text("Sign Up")
                    .fontWeight(.heavy)
                    .font(.title3)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(LinearGradient(gradient: Gradient(colors: [.pink, .purple]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(40)
            })
            HStack {
                NavigationLink(destination: HRLoginView()) {
                    Text("Already have an account? Log In")
                        .foregroundLinearGradient(colors: [.pink, .purple], startPoint: .leading, endPoint: .trailing)
                }
                Spacer()
            }.padding(10)
        }
        .padding(20)
        .navigationBarHidden(true)
    }
}

#Preview {
    HRSignupView()
}
