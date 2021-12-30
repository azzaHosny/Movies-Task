//
//  GetMoviesListUseCase.swift
//  Movies
//
//  Created by azah on 12/30/21.
//

import RxSwift

protocol GetMoviesListUseCaseProtocol {
    func build(param: PopularMoviesRequest, moviesRepo: MoviesListRepo) -> Observable<[MoviesUIViewModel]>
}

class GetMoviesListUseCase: GetMoviesListUseCaseProtocol {
    func build(param: PopularMoviesRequest, moviesRepo: MoviesListRepo) -> Observable<[MoviesUIViewModel]> {
        var moviesUIModel = [MoviesUIViewModel]()
        return moviesRepo.getPopularMovies(param: param).map {
            let moviesObject = $0
            for movie in moviesObject.movies {
                let viewModel = MoviesUIViewModel(movieName: movie.title, movieImage: movie.posterPath)
                moviesUIModel.append(viewModel)
            }
             return moviesUIModel
        }
   }
}
