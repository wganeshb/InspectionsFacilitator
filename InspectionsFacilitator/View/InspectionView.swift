//
//  QuizView.swift
//  InspectionsFacilitator
//
//  Created by Ganesh Balasaheb Waghmode on 22/06/24.
//

import SwiftUI

enum ActionToPerform {
    case update
    case submit
}

struct InspectionView: View {
    
    @EnvironmentObject var appState: AppState
    @State var action: ActionToPerform
    
    @State var showAlert = false
    
    @State var questions: [QuestionModel]? = []
    @State var inspectionType: String? = "Healthcare"
    
    @StateObject var inspectionsResponseViewModel = InspectionsResponseViewModel()
    @StateObject var inspectionSubmissionViewModel = InspectionSubmissionViewModel()
    
    var body: some View {
        
        VStack {
            
            Text("Inspection type: \(inspectionType ?? "")")
            Text("number of questions in the inspection : \(questions?.count ?? 0)")
            List {
//                ForEach(questions ?? [], id:\.id) { questionModel in
//                    //Text(questionModel.name)
//                    QuestionView(question: questionModel)
//                }
                ForEach(inspectionsResponseViewModel.questions ?? [], id:\.id) { questionModel in
                    //Text(questionModel.name)
                    QuestionView(question: questionModel)
                }
            }
            
            HStack {
                Button("Save") {
                    // Save to database
                }
                .padding()
                .frame(width: 100, height: 50)
                .foregroundColor(.white.opacity(0.8))
                .background(.green.opacity(0.8))
                .cornerRadius(3.0)
                    
                Button("Submit") {
                    // Submit to backend using API call
                    print("Submit button pressed")
                    print("Can submit the inspection : \(self.inspectionsResponseViewModel.canSubmitInspection(questionList: inspectionsResponseViewModel.questions ?? []))")
                    
                    if let inspectionModelReponse = inspectionsResponseViewModel.inspectionModelResponse {
                        Task {
                            let alert = await inspectionSubmissionViewModel.submit(inspectionModelObject: inspectionModelReponse)
                        }
                    }
                }
                .padding()
                .frame(width: 100, height: 50)
                .foregroundColor(.white.opacity(0.8))
                .background(.green.opacity(0.8))
                .cornerRadius(3.0)
            }//.alert("The inspection submitted", isPresented: $showAlert, actions: {})
        }.task {
            await MainActor.run {
                print("questions: \(questions?.count ?? 0)")
            }
        }
        
    }
}

#Preview {
    InspectionView(action: .update)
}
