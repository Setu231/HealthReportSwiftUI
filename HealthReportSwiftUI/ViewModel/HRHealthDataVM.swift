//
//  HRHealthDataVM.swift
//  HealthReportSwiftUI
//
//  Created by Setu Desai on 2/12/24.
//

import Firebase
import FirebaseFirestore

final class HRHealthDataVM: ObservableObject {
    
    @Published var bloodPressureDataList = [HRBloodPressureData]()
    
    init() {
        FirebaseApp.configure()
        fetchData()
    }
    
    func addData(systolic: String, diastolic: String) {
        guard !systolic.isEmpty && !diastolic.isEmpty else { return }
        let db = Firestore.firestore()
        let ref = db.collection("BPHealthReports")
        let bloodPressure = HRBloodPressure(id: UUID().uuidString, systolic: systolic, diastolic: diastolic)
        ref.addDocument(data: ["id": UUID().uuidString, "systolic": bloodPressure.systolic, "diastolic": bloodPressure.diastolic])
        fetchData()
    }
    
    func updateData(bloodPressureData: HRBloodPressureData, systolicText: String, diastolicText: String) {
        let db = Firestore.firestore()
        let ref = db.collection("BPHealthReports")
        ref.whereField("id", isEqualTo: bloodPressureData.bloodPressure.id).getDocuments { snapshot, err in
            guard err == nil else {
                print(err?.localizedDescription ?? "")
                return
            }
            
            if let snapshot {
                for document in snapshot.documents {
                    document.reference.updateData(["systolic": systolicText, "diastolic": diastolicText])
                    self.fetchData()
                }
            }
        }
    }
    
    func fetchData() {
        bloodPressureDataList.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection("BPHealthReports")
        
        ref.getDocuments { snapshot, error in
            guard error == nil else {
                print(error?.localizedDescription ?? "")
                return
            }
            
            if let snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    
                    let id = data["id"] as? String ?? ""
                    let systolic = data["systolic"] as? String ?? ""
                    let diastolic = data["diastolic"] as? String ?? ""
                    let bloodPressure = HRBloodPressure(id: id, systolic: systolic, diastolic: diastolic)
                    let pressureStatus = self.getPressureStatus(systolic: systolic, diastolic: diastolic)
                    let bloodPressureData = HRBloodPressureData(id: id, bloodPressure: bloodPressure, pressureStatus: pressureStatus)
                    self.bloodPressureDataList.append(bloodPressureData)
                }
            }
        }
    }
    
    func deleteData(offsets: IndexSet) {
        let db = Firestore.firestore()
        let ref = db.collection("BPHealthReports")
        let itemsToDelete = offsets.lazy.map { self.bloodPressureDataList[$0] }
        itemsToDelete.forEach { lineItem in
            ref.document(lineItem.id).delete { error in
                if let error {
                    print("Error removing document: \(error)")
                }
                else {
                    print("Document successfully removed!")
                    self.bloodPressureDataList.remove(atOffsets: offsets)
                }
            }
        }
    }
    
    func getPressureStatus(systolic: String, diastolic: String) -> HRBloodPressureStatus {
        let systolicValue = Int(systolic) ?? 0
        let diastolicValue = Int(diastolic) ?? 0
        if systolicValue < 120 && diastolicValue < 80 {
            return HRBloodPressureStatus.normal
        } else if (systolicValue >= 120 && systolicValue <= 129) && diastolicValue < 80 {
            return HRBloodPressureStatus.elevated
        } else if (systolicValue >= 120 && systolicValue <= 129) || (diastolicValue >= 80 && diastolicValue <= 89) {
            return HRBloodPressureStatus.hypertensionFirst
        } else if systolicValue > 180 || diastolicValue > 120 {
            return HRBloodPressureStatus.hypertensionCrisis
        } else if systolicValue >= 140 || diastolicValue >= 90 {
            return HRBloodPressureStatus.hypertensionSecond
        } else {
            return HRBloodPressureStatus.unidentified
        }
    }
}
