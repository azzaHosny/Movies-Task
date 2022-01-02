//
//  LoginViewModel.swift
//  Movies
//
//  Created by azah on 12/30/21.
//

import RxSwift
enum LoginScreenStatus {
    case valid
    case notValid(errorMsg: [String])
}
class LoginViewModel {
    
    private var cordinator: LoginCordinatorProtocol
    private var textValidator: Validator
    var validationSubject = BehaviorSubject<LoginScreenStatus?>(value: nil)
    
    init(cordinator: LoginCordinatorProtocol, validator: Validator){
        self.cordinator = cordinator
        self.textValidator = validator
    }
    
    func textChange(email: String?, password: String?) {
        let isValid = textValidator.validate(email: email, password: password)
        validationSubject.onNext(isValid)
    }
    func routToMoviesList() {
        cordinator.routToMoviesList()
    }
    
}
