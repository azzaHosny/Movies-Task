//
//  GetMoviesListUseCase.swift
//  Movies
//
//  Created by azah on 12/30/21.
//

import RxSwift

protocol GetMoviesListUseCaseProtocol {
    func build(param: PopularMoviesRequest, moviesRepo: MoviesListRepo) -> Observable<GetPopularMoviesViewModelStatus>
}

class GetMoviesListUseCase: GetMoviesListUseCaseProtocol {
    func build(param: PopularMoviesRequest, moviesRepo: MoviesListRepo) -> Observable<GetPopularMoviesViewModelStatus> {
        
        return moviesRepo.getPopularMovies(param: param).map({
            guard let moviesObject = $0.movies else {return .fail(errorMsg: "fail to get popular movies list")}
        let imageBaseURl = URLReader.readPropertyList(urlType: "imgBaseUrl")
        let movies = moviesObject.map({MoviesUIViewModel(movieName: $0.title, movieImage: imageBaseURl + $0.posterPath)})
        let response = PopularMoviesResponseUIViewModel(pageNum: $0.page, totalNumOfPages: $0.totalPages, popularMovies: movies)
        return .sucess(respone: response)
                
        })
    }
}
