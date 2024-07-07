//
//  InspectionSubmissionViewModelTests.swift
//  InspectionsFacilitatorTests
//
//  Created by Ganesh Balasaheb Waghmode on 06/07/24.
//

import XCTest
@testable import InspectionsFacilitator

final class InspectionSubmissionViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_InspectionSubmissionViewModel_ReturnSuccess() async {
        //Arrange
        let sut = InspectionSubmissionViewModel()
        var inspectionsModel: InspectionsModelResponse?
        let fileName = "InspectionModel"
        let fileType = "json"
        
        if let path = Bundle.main.path(forResource: fileName, ofType: fileType) {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                inspectionsModel = try JSONDecoder().decode(InspectionsModelResponse.self, from: data)
            } catch {
                print(error.localizedDescription)
            }
        }
        
        // Act
        await sut.submit(inspectionModelObject: inspectionsModel!)
        
        //Assert
        XCTAssertTrue(sut.status == true)
        XCTAssertNil(sut.inspectionSubmissionError)
    }
}
