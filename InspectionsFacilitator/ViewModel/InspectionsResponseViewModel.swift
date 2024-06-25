//
//  InspectionsResponseViewModel.swift
//  InspectionsFacilitator
//
//  Created by Ganesh Balasaheb Waghmode on 21/06/24.
//

import Foundation

final class InspectionsResponseViewModel: ObservableObject {
    
    // @Published var inspectionModel: InspectionsModel?
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
            
            print("inspections ** : \(inspectionsResponseModel)")
            print("\n------------------------------------------------------------------------")
            print("question model array : \(String(describing: self.questions))")
            
        } catch (let error) {
            print(error.localizedDescription)
        }
    }
    
    func canSubmitInspection(questionList: [QuestionModel]?) -> Bool {
        
        print("questionList count : \(questionList?.count ?? 0)")
        for question in questionList ?? [] {
            print("Question : \(question.name), answer selected : \(question.selectedAnswerChoiceId ?? 0)")
            if question.selectedAnswerChoiceId != nil {
                canSubmit = true
            }
            else {
                canSubmit = false
            }
        }
        return canSubmit
    }
    
    func printData() {
        Utility().printDivider()
        print("Questions : \(String(describing: self.questions?.count))")
        Utility().printDivider()
    }
}
