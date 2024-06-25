//
//  InspectionSubmissionViewModel.swift
//  InspectionsFacilitator
//
//  Created by Ganesh Balasaheb Waghmode on 25/06/24.
//

import Foundation

class InspectionSubmissionViewModel: ObservableObject {
    @Published var status: Bool = false
    
    func submit(inspectionModelObject: InspectionsModelResponse) async {
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        do {
            let loginStatus = try await WebService().submit(inspectionModelObject: inspectionModelObject)
            await MainActor.run {
                self.status = loginStatus
            }
            Utility().printDivider()
            print("Submit status : ", self.status)
        } catch (let error) {
            print(error.localizedDescription)
        }
    }
}
