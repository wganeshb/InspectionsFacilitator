//
//  InspectionReponseViewModelTest.swift
//  InspectionsFacilitatorTests
//
//  Created by Ganesh Balasaheb Waghmode on 06/07/24.
//

import XCTest
@testable import InspectionsFacilitator

final class InspectionReponseViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_InspectionReponseViewModel_ReturnsQuestionsArray() async {
        //Arrange
        let sut = InspectionsResponseViewModel()
        
        // Act
        await sut.getInspection()
        
        //Assert
        XCTAssertTrue(sut.questions != nil)
    }
}
