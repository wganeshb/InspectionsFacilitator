//
//  LoginRegisterWebServiceTest.swift
//  InspectionsFacilitatorTests
//
//  Created by Ganesh Balasaheb Waghmode on 05/07/24.
//

import XCTest
@testable import InspectionsFacilitator

final class WebServiceTests: XCTestCase {

    var registeredEmailId = ""
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // MARK: Register Web Services *
    func testRegisterWebService_WhenGivenRandomNewEmail_ReturnsSuccess() async {
        //Arrange
        let sut = WebService()
        var registerStatus = false
        var registerErrorResponse: ErrorCases?
        
        let mockEmailId = String().getRandomEmail(currentStringAsUsername: true)
        print("mockEmailId : \(mockEmailId)")
        
        // Act
        do {
            registerStatus = try await sut.register(email: mockEmailId, password: "1234")
        } catch (let error) {
            XCTAssertFalse(registerStatus)
            registerErrorResponse = error as? ErrorCases
        }
        
        // this value is stored to check the register login test cases for known user
        if registerStatus == true {
            self.registeredEmailId = mockEmailId
        }
        
        //Assert
        XCTAssertTrue(registerStatus)
        XCTAssertNil(registerErrorResponse)
    }
    
    func testLoginWebService_WhenGivenIncorrectCredentials_ReturnsFalseAndError() async {
        //Arrange
        let sut = WebService()
        var loginStatus = false
        var loginErrorResponse: ErrorCases?
        
        let mockEmailId = String().getRandomEmail(currentStringAsUsername: true)
        print("mockEmailId : \(mockEmailId)")
        
        // Act
        do {
            loginStatus = try await sut.login(email: mockEmailId, password: "1234")
        } catch (let error) {
            XCTAssertFalse(loginStatus)
            loginErrorResponse = error as? ErrorCases
        }
        
        //Assert
        XCTAssertTrue(!loginStatus)
        XCTAssertNotNil(loginErrorResponse)
    }
    
    // MARK: Inspections fetch web services
    func test_InspectionResponseWebServiceGetInspectionsList_returnInspectionsModelResponse() async {
        
        // Assert
        let sut = WebService()
        var inspectionModelResponse: InspectionsModelResponse?
        var getInspectioListError: ErrorCases?
        
        // Act
        do {
            inspectionModelResponse = try? await sut.getInspectionsList()
        } catch (let error) {
            getInspectioListError = error as? ErrorCases
        }
        
        //Assert
        XCTAssertNotNil(inspectionModelResponse)
        XCTAssertNil(getInspectioListError)
        
    }
    
    // MARK: Register login happy flow
    /*
        Testing register webService with new email and return succes
        Then Testing the login webService with the recently registered email
     */
    func test_LoginRegisterWebService_HappyFlow() async {
        
        let registeredEmailId = await testRegisterWebService_WhenGivenRandomNewEmail_Success()
        self.registeredEmailId = registeredEmailId
        XCTAssertNotEqual(registeredEmailId, "")
        
        await testLoginWebService_WhenGivenCorrectCredentials_ReturnsSuccess(mockEmail: registeredEmailId)
    }
    
    func testRegisterWebService_WhenGivenRandomNewEmail_Success() async -> String {
        //Arrange
        let sut = WebService()
        var registerStatus = false
        var registerErrorResponse: ErrorCases?
        
        let mockEmailId = String().getRandomEmail(currentStringAsUsername: true)
        print("mockEmailId : \(mockEmailId)")
        
        // Act
        do {
            registerStatus = try await sut.register(email: mockEmailId, password: "1234")
        } catch (let error) {
            XCTAssertFalse(registerStatus)
            registerErrorResponse = error as? ErrorCases
        }
        
        //Assert
        XCTAssertTrue(registerStatus)
        XCTAssertNil(registerErrorResponse)
        
        if registerStatus {
            return mockEmailId
        }
        
        return ""
    }
    
    func testLoginWebService_WhenGivenCorrectCredentials_ReturnsSuccess(mockEmail: String) async {
        //Arrange
        let sut = WebService()
        var loginStatus = false
        var loginErrorResponse: ErrorCases?
        
        //Act
        do {
            loginStatus = try await sut.login(email: mockEmail, password: "1234")
        } catch (let error) {
            XCTAssertFalse(loginStatus)
            loginErrorResponse = error as? ErrorCases
        }
        //Assert
        XCTAssertTrue(loginStatus)
        XCTAssertNil(loginErrorResponse)
    }
    
    
    func test_InspectionSubmissionWebService_ReturnSuccess() async {
        //Arrange
        let sut = WebService()
        var inspectionsModel: InspectionsModelResponse?
        var submitStatus = false
        var submitErrorResponse: ErrorCases?
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
        do {
            submitStatus = try await sut.submit(inspectionModelObject: inspectionsModel!)
        } catch (let error) {
            submitErrorResponse = error as? ErrorCases
        }
        
        //Assert
        XCTAssertTrue(submitStatus)
        XCTAssertNil(submitErrorResponse)
    }
    
    // MARK: Test Register with known user credentials.
    
    func testRegisterWebService_WhenGivenRegisteredEmail_ReturnsFailureState() async {
        //Arrange
        let sut = WebService()
        var registerStatus = false
        var registerErrorResponse: ErrorCases?
        await testRegisterWebService_WhenGivenRandomNewEmail_ReturnsSuccess()
        
        //Act
        do {
            registerStatus = try await sut.register(email: self.registeredEmailId, password: "1234")
        } catch (let error) {
            XCTAssertFalse(registerStatus)
            registerErrorResponse = error as? ErrorCases
        }
        
        //Assert
        XCTAssertTrue(!registerStatus)
        XCTAssertFalse(registerStatus)
        XCTAssertNotNil(registerErrorResponse)
    }
     
    
    // MARK: Login with known user credentials
    
    func testLoginWebService_WhenGivenCorrectCredentials_ReturnsSuccess() async {
        //Arrange
        let sut = WebService()
        var loginStatus = false
        var loginErrorResponse: ErrorCases?
        
        if self.registeredEmailId.isEmpty {
            await testRegisterWebService_WhenGivenRandomNewEmail_ReturnsSuccess()
        }
        
        //Act
        do {
            loginStatus = try await sut.login(email: self.registeredEmailId, password: "1234")
        } catch (let error) {
            XCTAssertFalse(loginStatus)
            loginErrorResponse = error as? ErrorCases
        }
        //Assert
        XCTAssertTrue(loginStatus)
        XCTAssertNil(loginErrorResponse)
    }
     
    
}

extension String {
    
    func getRandomEmail(currentStringAsUsername: Bool = false) -> String {
        let providers = ["gmail.com", "hotmail.com", "icloud.com", "live.com"]
        let randomProvider = providers.randomElement()!
        if currentStringAsUsername && self.count > 0 {
            return "\(self)@\(randomProvider)"
        }
        let username = UUID.init().uuidString.replacingOccurrences(of: "-", with: "")
        return "\(username)@\(randomProvider)"
    }
}
