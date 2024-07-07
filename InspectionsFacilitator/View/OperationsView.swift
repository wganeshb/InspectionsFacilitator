//
//  OperationsView.swift
//  InspectionsFacilitator
//
//  Created by Ganesh Balasaheb Waghmode on 22/06/24.
//

import SwiftUI

struct OperationsView: View {
    
    @ObservedObject var inspectionsResponseViewModel = InspectionsResponseViewModel()
    
    var body: some View {
        
        NavigationView {
            VStack {
                NavigationLink {
                    InspectionView(action: .submit, inspectionsResponseViewModel: self.inspectionsResponseViewModel)
                } label: {
                    Text("Start")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue.opacity(0.80))
                        .cornerRadius(10.0)
                }
                Spacer()
                    .padding(.top, 20.0)
            }
            
        }.task {
            
            inspectionsResponseViewModel.questions = []
            inspectionsResponseViewModel.categories = []
            inspectionsResponseViewModel.inspectionType = ""
            inspectionsResponseViewModel.inspectionModelResponse = nil
            
            if inspectionsResponseViewModel.questions?.count == 0 {
                await inspectionsResponseViewModel.getInspection()
                inspectionsResponseViewModel.questions = inspectionsResponseViewModel.questions?.unique{$0.id}
            }
        }
    }
}

extension Array {
    
    func unique<T:Hashable>(map: ((Element) -> (T)))  -> [Element] {
        var set = Set<T>() //the unique list kept in a Set for fast retrieval
        var arrayOrdered = [Element]() //keeping the unique list of elements but ordered
        for value in self {
            if !set.contains(map(value)) {
                set.insert(map(value))
                arrayOrdered.append(value)
            }
        }
        return arrayOrdered
    }
}

#Preview {
    OperationsView()
}
