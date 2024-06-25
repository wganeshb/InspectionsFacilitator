//
//  SurveyModel.swift
//  InspectionsFacilitator
//
//  Created by Ganesh Balasaheb Waghmode on 21/06/24.
//

import Foundation

class SurveyModel: Codable {
    let id: Int
    let categories: [CategoryModel]
}
