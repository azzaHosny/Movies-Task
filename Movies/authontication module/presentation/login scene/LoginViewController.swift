//
//  LoginViewController.swift
//  Movies
//
//  Created by azah on 12/30/21.
//

import UIKit
import RxCocoa
import RxSwift

class LoginViewController: UIViewController {
    
    private var disposeBag = DisposeBag()
    private let viewModel: LoginViewModel

    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func loginIsPressed(_ sender: Any) {
        viewModel.routToMoviesList()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enableLoginButton(isEnabled: false)
        observeOnTextField(emailTextField)
        observeOnTextField(passwordTextField)
        subscribOnTextValidatiorSubject()
    }
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "LoginViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func observeOnTextField(_ textField: UITextField) {
        textField.rx.controlEvent([.editingChanged]).asObservable()
            .subscribe(onNext: { [weak self] in
                guard let self = self else {return}
                self.viewModel.textChange(email: self.emailTextField.text, password: self.passwordTextField.text)
            })
            .disposed(by: disposeBag)
    }

    private func subscribOnTextValidatiorSubject() {
        viewModel.validationSubject.subscribe { [weak self] (result) in
            guard let self = self else {return}
            if let value = result.element, let status = value {
                self.handelTextStatus(status: status)
            }
        }.disposed(by: disposeBag)

    }
    
    private func handelTextStatus(status: LoginScreenStatus) {
        switch status {
        case .valid:
            enableLoginButton(isEnabled: true)
        case .notValid(errorMsg: let errors):
            print(errors)
            enableLoginButton(isEnabled: false)
        }
    }
    
    func enableLoginButton(isEnabled: Bool) {
        loginBtn.isEnabled = isEnabled
        loginBtn.alpha = isEnabled ? 1.0 : 0.5
    }

}
