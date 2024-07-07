//
//  InspectionsResponseViewModel.swift
//  InspectionsFacilitator
//
//  Created by Ganesh Balasaheb Waghmode on 21/06/24.
//

import Foundation

final class InspectionsResponseViewModel: ObservableObject {
    
    @Published var questions: [QuestionModel]? = []
    @Published var categories: [CategoryModel]? = []
    @Published var inspectionType: String? = ""
    @Published var inspectionModelResponse : InspectionsModelResponse?
    
    var canSubmit: Bool = false
    
    func getInspection() async {
        do {
            let inspectionsResponseModel = try await WebService().getInspectionsList()
            let categories = inspectionsResponseModel.inspection.survey.categories
            await MainActor.run {
                inspectionModelResponse = inspectionsResponseModel
                self.inspectionType = inspectionsResponseModel.inspection.inspectionType.name
            }
            
            for category in categories {
                for question in category.questions {
                    await MainActor.run {
                        self.questions?.append(question)
                    }
                }
            }
            
        } catch (let error) {
            
        }
    }
    
    func canSubmitInspection(questionList: [QuestionModel]?) -> Bool {
        
        for question in questionList ?? [] {
            print("question.selectedAnswerChoiceId : \(question.selectedAnswerChoiceId)")
            if question.selectedAnswerChoiceId != nil {
                canSubmit = true
            }
            else {
                canSubmit = false
                return canSubmit
            }
        }
        return canSubmit
    }
    
}
