//
//  MoviesListRepo.swift
//  Movies
//
//  Created by azah on 12/30/21.
//

import RxSwift

protocol MoviesListRepo {
    func getPopularMovies(param: PopularMoviesRequest) -> Observable<MoviesResponse>

}
