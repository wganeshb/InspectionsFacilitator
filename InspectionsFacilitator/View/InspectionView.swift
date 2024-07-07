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

enum ActiveAlert {
    case first, second
}

struct InspectionView: View {
    
    @EnvironmentObject var appState: AppState
    @State var action: ActionToPerform
    
    @State var showAlert = false
    @State var showActivity = true
    @State private var activeAlert: ActiveAlert = .first
    
    @ObservedObject var inspectionsResponseViewModel = InspectionsResponseViewModel()
    @ObservedObject var inspectionSubmissionViewModel = InspectionSubmissionViewModel()
    
    var body: some View {
        
        ZStack {
            VStack {
                
                Text("Inspection type: \(inspectionsResponseViewModel.inspectionType ?? "")")
                Text("number of questions in the inspection : \(inspectionsResponseViewModel.questions?.count ?? 0)")
                List {
                    ForEach(inspectionsResponseViewModel.questions ?? [], id:\.id) { questionModel in
                        
                        QuestionView(question: questionModel) { question in
                            if let index = inspectionsResponseViewModel.questions?.firstIndex(where: {$0.id == question.id}) {
                                inspectionsResponseViewModel.questions?[index] = question
                            }
                        }
                    }
                }
                
                HStack {
                    
                    Button("Submit") {
                        self.showActivity = !self.showActivity
                        self.inspectionsResponseViewModel.canSubmit = false
                        if (self.inspectionsResponseViewModel.canSubmitInspection(questionList: inspectionsResponseViewModel.questions ?? []))
                        {
                            if let inspectionModelReponse = inspectionsResponseViewModel.inspectionModelResponse {
                                Task {
                                    try? await Task.sleep(nanoseconds: 1_000_000_000)
                                    await inspectionSubmissionViewModel.submit(inspectionModelObject: inspectionModelReponse)
                                    self.showActivity.toggle()
                                    self.showAlert = true
                                    self.activeAlert = .second
                                }
                            }
                            else {
                                self.showActivity = !self.showActivity
                                self.showAlert = true
                                self.activeAlert = .first
                                
                            }
                        }
                        else {
                            self.showActivity = !self.showActivity
                            self.showAlert = true
                            self.activeAlert = .first
                        }
                    }
                    .alert(isPresented: $showAlert, content: {
                        switch activeAlert {
                            case .first:
                                return Alert(
                                    title: Text("Alert"),
                                    message: Text("All the inspections are mandatory"),
                                    dismissButton: .default(Text("Close"))
                                )
                            case .second:
                                return Alert(
                                    title: Text("Alert"),
                                    message: Text("Inspection submitted successfully"),
                                    dismissButton: .default(Text("Close"))
                                )
                            }
                    })
                    .padding()
                    .frame(width: 100, height: 50)
                    .foregroundColor(.white.opacity(0.8))
                    .background(.green.opacity(0.8))
                    .cornerRadius(3.0)
                }
            }
            LoaderView(tintColor: .blue, scaleSize: 3.0).hidden(showActivity)
        }
    }
}

#Preview {
    InspectionView(action: .update)
}
