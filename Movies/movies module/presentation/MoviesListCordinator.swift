//
//  MoviesListCordinator.swift
//  Movies
//
//  Created by azah on 12/30/21.
//

import UIKit

class MoviesListCordinator {
    let navigationController: UINavigationController
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let useCase = GetMoviesListUseCase()
        let repo = MoviesListRepoImplementation()
        let viewModel = MoviesListViewModel(cordinator: self, getPopularMoviesUseCase: useCase, movieRepo: repo)
        let viewController = MoviewListViewController.init(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}
