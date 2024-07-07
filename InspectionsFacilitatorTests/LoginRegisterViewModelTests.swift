//
//  LoginRegisterViewModelTest.swift
//  InspectionsFacilitatorTests
//
//  Created by Ganesh Balasaheb Waghmode on 06/07/24.
//

import XCTest
@testable import InspectionsFacilitator

final class LoginRegisterViewModelTests: XCTestCase {
    
    var mockUserEmailId = ""

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // MARK: LoginRegister happy flow
    func test_LoginRegisterViewModel_HappyPath() async {
        let mockEmailId = await test_LoginRegisterViewModel_RegisterWithRandomNotRegisteredRandomCredential_ReturnsRegisteredUserEmailOnSuccess()
        
        await test_LoginRegisterViewModel_LoginWithRegisteredCredentials_ReturnSuccess(registeredEmailId: mockEmailId)
    }
    
    func test_LoginRegisterViewModel_RegisterWithRandomNotRegisteredRandomCredential_ReturnsRegisteredUserEmailOnSuccess() async -> String {
        //Arrange
        let sut = LoginRegisterViewModel()
        let mockEmailId = String().getRandomEmail(currentStringAsUsername: true)
        
        // Act
        await sut.register(email: mockEmailId, password: "1234")
        
        //Assert
        XCTAssertTrue(sut.status == true)
        XCTAssertNil(sut.error)
        
        if sut.status == true {
            return mockEmailId
        }
        
        return ""
    }
    
    
    func test_LoginRegisterViewModel_LoginWithRegisteredCredentials_ReturnSuccess(registeredEmailId: String) async {
        //Arrange
        let sut = LoginRegisterViewModel()
        
        // Act
        await sut.login(email: registeredEmailId, password: "1234")
        
        //Assert
        XCTAssertTrue(sut.status == true)
        XCTAssertNil(sut.error)
    }
    
    
    // MARK: Test Register with known user credentials.
    
    func test_LoginRegisterViewModel_RegisterWithRegisteredCredentials_ReturnFailureAndError() async {
        //Arrange
        let sut = LoginRegisterViewModel()
        await registerUser()
        
        // Act
        await sut.register(email: mockUserEmailId, password: "1234")
        
        //Assert
        XCTAssertTrue(sut.status == false)
        XCTAssertTrue(sut.error != nil)
        XCTAssertNotNil(sut.error)
    }
    
    
    // MARK: Login with known user credentials.
    
    func test_LoginRegisterViewModel_LoginWithRegisteredCredentials_ReturnSuccess() async {
        //Arrange
        let sut = LoginRegisterViewModel()
        await registerUser()
        
        // Act
        await sut.login(email: mockUserEmailId, password: "1234")
        
        //Assert
        XCTAssertTrue(sut.status == true)
        XCTAssertNil(sut.error)
    }
    
    //MARK: This is to test conditions for registered user.
    
    func registerUser() async {
        //Arrange
        let sut = LoginRegisterViewModel()
        let mockEmailId = String().getRandomEmail(currentStringAsUsername: true)
        
        // Act
        await sut.register(email: mockEmailId, password: "1234")
        
        //Assert
        XCTAssertTrue(sut.status == true)
        XCTAssertNil(sut.error)
        
        if sut.status == true {
            mockUserEmailId = mockEmailId
        }
    }
    
}
