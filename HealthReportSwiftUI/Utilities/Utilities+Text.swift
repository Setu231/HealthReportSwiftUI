//
//  Utilities+Text.swift
//  HealthReportSwiftUI
//
//  Created by Setu Desai on 2/12/24.
//

import SwiftUI

extension Text {
    public func foregroundLinearGradient(colors: [Color], startPoint: UnitPoint, endPoint: UnitPoint) -> some View {
        self.overlay {
            LinearGradient(colors: colors, startPoint: startPoint, endPoint: endPoint).mask(self)
        }
    }
}

