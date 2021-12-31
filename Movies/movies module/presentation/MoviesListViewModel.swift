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

enum GetPopularMoviesViewModelStatus {
    case sucess(movies: [MoviesUIViewModel])
    case fail(errorMsg: String)
    case loading
}

class MoviesListViewModel {
    
    let movieRepo: MoviesListRepo
    var cordinator: MoviesListCordinator
    let getPopularMoviesUseCase: GetMoviesListUseCaseProtocol
    let disposBag = DisposeBag()
    let behavioralSbj = BehaviorSubject<GetPopularMoviesViewModelStatus>(value: .loading)
    
    init(cordinator: MoviesListCordinator, getPopularMoviesUseCase: GetMoviesListUseCaseProtocol, movieRepo: MoviesListRepo){
        self.getPopularMoviesUseCase = getPopularMoviesUseCase
        self.cordinator = cordinator
        self.movieRepo = movieRepo
    }
    
    func getPopularMovieList(params: PopularMoviesRequest) {
        getPopularMoviesUseCase.build(param: params, moviesRepo: movieRepo).subscribe( onNext: { [weak self] result in
            guard let self = self else { return }
            self.behavioralSbj.onNext(result)
        }, onError: { [weak self] error in
            guard let selfObjct = self else { return }
            self.behavioralSbj.onNext(.fail(error.localizedDescription))
        }).disposed(by: disposBag)
    }
   
}
