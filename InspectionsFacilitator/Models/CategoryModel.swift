//
//  Category.swift
//  InspectionsFacilitator
//
//  Created by Ganesh Balasaheb Waghmode on 21/06/24.
//

import Foundation

class CategoryModel: Codable {
    let id: Int
    let name: String
    let questions: [QuestionModel] 
}
