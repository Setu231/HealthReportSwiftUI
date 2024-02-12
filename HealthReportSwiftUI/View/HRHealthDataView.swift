//
//  HRHealthDataView.swift
//  HealthReportSwiftUI
//
//  Created by Setu Desai on 2/12/24.
//

import SwiftUI

struct HRHealthDataView: View {
    
    @EnvironmentObject var hrHealthDataViewModel: HRHealthDataVM
    @State var isAddingScreen = false
    @State var isUpdating = false
    @State var bloodPressureData: HRBloodPressureData?
    
    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    ForEach($hrHealthDataViewModel.bloodPressureDataList) { eachBPData in
                        HStack {
                            Image(systemName: "heart")
                                .foregroundStyle(.white)
                            Text(eachBPData.pressureStatus.wrappedValue.rawValue)
                                .foregroundStyle(.white)
                            Spacer()
                            Text("\(eachBPData.bloodPressure.systolic.wrappedValue) / \(eachBPData.bloodPressure.diastolic.wrappedValue)")
                                .foregroundStyle(.white)
                        }
                        .frame(height: 40)
                        .padding(10)
                        .listRowBackground(eachBPData.pressureStatus.wrappedValue.statusColor)
                        .onTapGesture {
                            isAddingScreen = true
                            isUpdating = true
                            bloodPressureData = eachBPData.wrappedValue
                        }
                    }.onDelete { offset in
                        hrHealthDataViewModel.deleteData(offsets: offset)
                    }
                }
                .listStyle(.plain)
                .id(UUID())
                .disabled(isAddingScreen)
                .listStyle(PlainListStyle())
                .blur(radius: isAddingScreen ? 20 : 0)
                .navigationTitle("Health Report")
                .navigationBarBackButtonHidden(true)
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            isAddingScreen = true
                            isUpdating = false
                        }) {
                            Image(systemName: "plus")
                                .foregroundStyle(.black)
                        }
                    }
                })
                
                if isAddingScreen && isUpdating {
                    if let sys = bloodPressureData?.bloodPressure.systolic, let dia = bloodPressureData?.bloodPressure.diastolic {
                        HRHealthDetailAddView(systolicText: sys, diastolicText: dia, isAddingScreen: $isAddingScreen, isUpdating: $isUpdating, bloodPressureData: bloodPressureData)
                    }
                } else if isAddingScreen && !isUpdating {
                    HRHealthDetailAddView(isAddingScreen: $isAddingScreen, isUpdating: $isUpdating)
                }
            }
        }
    }
}

#Preview {
    HRHealthDataView()
        .environmentObject(HRHealthDataVM())
}
