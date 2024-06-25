//
//  Question.swift
//  InspectionsFacilitator
//
//  Created by Ganesh Balasaheb Waghmode on 13/06/24.
//

import SwiftUI

struct QuestionView: View {
    
    @State var question: QuestionModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(question?.name ?? "Not applicable")
                .padding(.top, 10)
            
            ForEach(question?.answerChoices ?? [], id:\.id) { answerChoice in
                HStack {
                    Button(action: {
                        print(answerChoice.name)
                        print("selected answer before selection: \(question?.selectedAnswerChoiceId )")
                        //question?.selectedAnswerChoiceId = answerChoice.id
                        question?.updateAnswerChoice(answerChoice: answerChoice.id)
                        print("selected answer after selection: \(question?.selectedAnswerChoiceId )")
                    }, label: {
                        if question?.selectedAnswerChoiceId == answerChoice.id {
                            Circle()
//                                .stroke()
//                                .shadow(radius: 3)
//                                .frame(width: 30, height: 30, alignment: .center)
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
                .onTapGesture {
                    
                }
                //Text(answerChoice.name)
            }
            .padding(.bottom, 10)
        }
        .padding(.horizontal, 20)
        .frame(width: 340, height: 550, alignment: .leading)
        .background(Color(uiColor: .systemGray6))
        .cornerRadius(10.0)
        .shadow(color: Color(uiColor: .label).opacity(0.2), radius: 10)
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView()
    }
}
