//
//  LoginCordinator.swift
//  Movies
//
//  Created by azah on 12/30/21.
//

import UIKit
protocol LoginCordinatorProtocol {
    func start()
    func routToMoviesList()
}

class LoginCordinator: LoginCordinatorProtocol {
    weak var navigationController: UINavigationController?
    init(navigationController: UINavigationController) {
       self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = LoginViewModel.init(cordinator: self, validator: TextValidator())
        let loginVC = LoginViewController.init(viewModel: viewModel)
        navigationController?.pushViewController(loginVC, animated: true)
    }
    
    func routToMoviesList() {
        MoviesListCordinator.init(navigationController: navigationController!).start()
   }
}
