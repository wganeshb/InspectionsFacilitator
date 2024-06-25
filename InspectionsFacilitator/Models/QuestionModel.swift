//
//  Question.swift
//  InspectionsFacilitator
//
//  Created by Ganesh Balasaheb Waghmode on 21/06/24.
//

import Foundation

class QuestionModel: Codable, Identifiable, ObservableObject {
    
    let id: Int
    let name: String
    let answerChoices: [AnswerChoiceModel]
    var selectedAnswerChoiceId: Int?
    
    func updateAnswerChoice(answerChoice: Int) {
        self.selectedAnswerChoiceId = answerChoice
    }
}
