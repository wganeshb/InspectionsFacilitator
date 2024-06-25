//
//  InspectionModel.swift
//  InspectionsFacilitator
//
//  Created by Ganesh Balasaheb Waghmode on 21/06/24.
//

import Foundation

class InspectionsModel: Codable {
    var id: Int
    var inspectionType: InspectionTypeModel
    var area: AreaModel
    var survey: SurveyModel
}
