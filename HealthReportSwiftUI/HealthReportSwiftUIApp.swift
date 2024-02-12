//
//  HealthReportSwiftUIApp.swift
//  HealthReportSwiftUI
//
//  Created by Setu Desai on 2/12/24.
//

import SwiftUI
import Firebase

@main
struct HealthReportSwiftUIApp: App {
    
    @State var hrHealthDataViewModel = HRHealthDataVM()
    @AppStorage("isUserLoggedIn") var isUserLoggedIn: Bool = false
    
    var body: some Scene {
        WindowGroup {
            if isUserLoggedIn {
                HRHealthDataView()
                    .environmentObject(hrHealthDataViewModel)
            } else {
                HRLoginView()
            }
        }
    }
}
