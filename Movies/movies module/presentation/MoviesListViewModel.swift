//
//  MoviesListViewModel.swift
//  Movies
//
//  Created by azah on 12/30/21.
//

import Foundation
import Foundation
import RxSwift

struct MoviesUIViewModel {
    let movieName: String
    let movieImage: String
}
struct PopularMoviesResponseUIViewModel {
    let pageNum: Int
    let totalNumOfPages: Int
    let popularMovies: [MoviesUIViewModel]
}

enum GetPopularMoviesViewModelStatus {
    case sucess(respone: PopularMoviesResponseUIViewModel)
    case fail(errorMsg: String)
    case loading
}

class MoviesListViewModel {
    
    let movieRepo: MoviesListRepo
    var cordinator: MoviesListCordinator
    let getPopularMoviesUseCase: GetMoviesListUseCaseProtocol
    let disposBag = DisposeBag()
    let getPopularMoviesSubject = BehaviorSubject<GetPopularMoviesViewModelStatus>(value: .loading)
    
    init(cordinator: MoviesListCordinator, getPopularMoviesUseCase: GetMoviesListUseCaseProtocol, movieRepo: MoviesListRepo){
        self.getPopularMoviesUseCase = getPopularMoviesUseCase
        self.cordinator = cordinator
        self.movieRepo = movieRepo
    }
    
    func getPopularMovieList(params: PopularMoviesRequest) {
        
        getPopularMoviesUseCase.build(param: params, moviesRepo: movieRepo).subscribe( onNext: { [weak self] result in
            guard let self = self else { return }
            self.getPopularMoviesSubject.onNext(result)
        }, onError: { [weak self] error in
            guard let self = self else { return }
            self.getPopularMoviesSubject.onNext(.fail(errorMsg: error.localizedDescription))
        }).disposed(by: disposBag)
    }
}
