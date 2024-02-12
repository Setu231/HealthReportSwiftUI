//
//  HRConstant.swift
//  HealthReportSwiftUI
//
//  Created by Setu Desai on 2/12/24.
//

import SwiftUI

enum AlertItem: String {
    case emptyDetail
    case invalidDetail
    case invalidEmail
    case notFullyFilled
    case noError
    
    var title: String {
        switch self {
        case .emptyDetail: return "Fill all details"
        case .invalidDetail: return "Invalid Credential"
        case .invalidEmail: return "Invalid Email Address"
        case .notFullyFilled: return "All Information Not Filled"
        default: return ""
        }
    }
    
    var message: String {
        switch self {
        case .emptyDetail: return "Please fill out all the details to preoceed."
        case .invalidDetail: return "It seems you have entered incorrect credentials"
        case .invalidEmail: return "The email you have added is not a valid email address"
        case .notFullyFilled: return "You have not filled out all the required details"
        default: return ""
        }
    }
}

struct HRBloodPressure {
    var id: String
    var systolic: String
    var diastolic: String
}

struct HRBloodPressureData: Identifiable {
    var id: String
    var bloodPressure: HRBloodPressure
    var pressureStatus: HRBloodPressureStatus
}

enum HRBloodPressureStatus: String {
    case normal = "Normal"
    case elevated = "Elevated"
    case hypertensionFirst = "Hypertension - Stage 1"
    case hypertensionCrisis = "Hypertensive Crisis"
    case hypertensionSecond = "Hypertension - Stage 2"
    case unidentified = "Data Issue"
    
    var statusColor: Color {
        switch self {
        case .normal:
            return Color.green
        case .elevated:
            return Color.yellow
        case .hypertensionFirst:
            return Color.orange
        case .hypertensionCrisis:
            return Color.red
        case .hypertensionSecond:
            return Color(uiColor: .systemRed)
        case .unidentified:
            return Color.gray
        }
    }
}

struct UserDetail: Codable {
    var firstName = ""
    var lastName = ""
    var email = ""
    var birthdate = Calendar.current.date(byAdding: .year, value: -18, to: Date()) ?? Date()
}
