//
//  MoviesTests.swift
//  MoviesTests
//
//  Created by azah on 1/1/22.
//

import XCTest
import RxSwift
@testable import Movies

class MoviesTests: XCTestCase {
    var viewModel: LoginViewModel!
    var disposeBag: DisposeBag!

    override func setUp() {
     viewModel = LoginViewModel.init(cordinator: LoginCordinator(navigationController: UINavigationController()), validator: TextValidator())
      disposeBag = DisposeBag()
    }
    
    override func setUpWithError() throws {

        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testEmailAndPasswordfailed() throws {
        try subscribEmailAndPasswordValidationIsFailed()
        viewModel.textChange(email: "a@b.", password: "assssddddddffffffffffffgggggggg45")
    }
    
    func testEmailfailed() throws {
        try subscribEmailValidationIsFailed()
        viewModel.textChange(email: "a@b.", password: "asss2345")
    }
    
    func testPasswordFailed() throws {
        try subscribOnTextValidatiorSubject()
        viewModel.textChange(email: "a@b.com", password: "asss")
    }
    
    func testEmailAndPasswordSuccess() throws {
        try subscribOnTextValidatiorSubjectSuccess()
        viewModel.textChange(email: "a@b.com", password: "asss2345")
    }

    func subscribOnTextValidatiorSubject() throws {
        viewModel.validationSubject.subscribe {(result) in
            if let value = result.element, let status = value {
                XCTAssertTrue(status == .notValid(errorMsg: [TextValidationType.password.errorMsg]))
            }
        }.disposed(by: disposeBag)
    }
    
    func subscribOnTextValidatiorSubjectSuccess() throws {
        viewModel.validationSubject.subscribe {(result) in
            if let value = result.element, let status = value {
                XCTAssertTrue(status == .valid)
            }
        }.disposed(by: disposeBag)
    }
    
    func subscribEmailValidationIsFailed() throws {
        viewModel.validationSubject.subscribe {(result) in
            if let value = result.element, let status = value {
                XCTAssertTrue(status == .notValid(errorMsg: [TextValidationType.email.errorMsg]))
            }
        }.disposed(by: disposeBag)
    }
    
    func subscribEmailAndPasswordValidationIsFailed() throws {
        viewModel.validationSubject.subscribe {(result) in
            if let value = result.element, let status = value {
                XCTAssertTrue(status == .notValid(errorMsg: [TextValidationType.email.errorMsg, TextValidationType.password.errorMsg]))
            }
        }.disposed(by: disposeBag)
    }

}
