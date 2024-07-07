//
//  InspectionSubmissionViewModel.swift
//  InspectionsFacilitator
//
//  Created by Ganesh Balasaheb Waghmode on 25/06/24.
//

import Foundation

class InspectionSubmissionViewModel: ObservableObject {
    @Published var status: Bool = false
    @Published var inspectionSubmissionError: ErrorCases?
    
    func submit(inspectionModelObject: InspectionsModelResponse) async {
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        do {
            let submitStatus = try await WebService().submit(inspectionModelObject: inspectionModelObject)
            await MainActor.run {
                self.status = submitStatus
            }
        } catch (let error) {
            self.status = false
            self.inspectionSubmissionError = error as? ErrorCases
        }
    }
}
