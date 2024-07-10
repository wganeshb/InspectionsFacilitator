//
//  Question.swift
//  InspectionsFacilitator
//
//  Created by Ganesh Balasaheb Waghmode on 13/06/24.
//

import SwiftUI

struct QuestionView: View {
    
    typealias TapAction = (QuestionModel) -> Void
    @State var question: QuestionModel
    var tapAction: TapAction?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(question.name)
                .padding(.top, 10)
            
            ForEach(question.answerChoices, id:\.id) { answerChoice in
                HStack {
                    Button(action: {
                        question.updateAnswerChoice(answerChoice: answerChoice.id)
                        
                        if let tapAction = tapAction {
                            tapAction(question)
                        }
                        
                    }, label: {
                        if question.selectedAnswerChoiceId == answerChoice.id {
                            Circle()
                                .shadow(radius: 3)
                                .frame(width: 30, height: 30, alignment: .center)
                                .foregroundColor(.blue.opacity(0.8))
                        }
                        else {
                            Circle()
                                .shadow(radius: 3)
                                .frame(width: 30, height: 30, alignment: .center)
                                .foregroundColor(.white)
                        }
                    })
                    .buttonStyle(.bordered)
                    Text(answerChoice.name)
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 20)
        .padding(.bottom, 20)
        .frame(width: 360, alignment: .leading)
        .background(Color(uiColor: .systemGray6))
        .cornerRadius(10.0)
        .shadow(color: Color(uiColor: .label).opacity(0.2), radius: 10)
    }
}

/*
struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView()
    }
}
*/
