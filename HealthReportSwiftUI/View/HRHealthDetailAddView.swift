//
//  HRHealthDetailAddView.swift
//  HealthReportSwiftUI
//
//  Created by Setu Desai on 2/12/24.
//

import SimplifySwiftUIPackage

struct HRHealthDetailAddView: View {
    
    @State var systolicText = ""
    @State var diastolicText = ""
    @Binding var isAddingScreen: Bool
    @Binding var isUpdating: Bool
    @State var bloodPressureData: HRBloodPressureData?
    @EnvironmentObject var hrHealthDataViewModel: HRHealthDataVM
    
    var body: some View {
        VStack(spacing: 10) {
            Spacer().frame(maxHeight: 50)
            VStack(alignment: .leading, spacing: 20) {
                Text("Systolic")
                    .multilineTextAlignment(.leading)
                    .font(.body)
                TextField("Systolic Value", text: $systolicText)
                Text("Diastolic")
                    .multilineTextAlignment(.leading)
                    .font(.body)
                TextField("Diastolic Value", text: $diastolicText)
            }.padding(20)
            Spacer()
            Button(action: {
                if isUpdating, let bloodPressureData {
                    hrHealthDataViewModel.updateData(bloodPressureData: bloodPressureData, systolicText: systolicText, diastolicText: diastolicText)
                } else {
                    hrHealthDataViewModel.addData(systolic: systolicText, diastolic: diastolicText)
                }
                isAddingScreen = false
            }, label: {
                Text(isUpdating ? "Update Data" : "Add New Data")
                    .textFont(fontStyle: .Medium07)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundStyle(.white)
                    .background(LinearGradient(gradient: Gradient(colors: [.pink, .purple]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(40)
            })
            .padding(20)
        }.frame(width: 320, height: 350)
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(radius: 40)
            .overlay(alignment: .topTrailing) {
                Button {
                    isAddingScreen = false
                } label: {
                    ZStack {
                        Circle()
                            .foregroundStyle(.white)
                            .frame(width: 30, height: 30)
                            .opacity(0.6)
                        Image(systemName: "xmark")
                            .foregroundStyle(.black)
                            .frame(width: 44, height: 44)
                    }
                }
                
            }
    }
}

#Preview {
    HRHealthDetailAddView(isAddingScreen: .constant(false), isUpdating: .constant(false))
}
