//
//  MoviesListRepoImpl.swift
//  Movies
//
//  Created by azah on 12/30/21.
//

import RxSwift

class MoviesListRepoImplementation: MoviesListRepo {
    func getPopularMovies(param: PopularMoviesRequest) -> Observable<MoviesResponse> {
        let url = URLReader.readPropertyList(urlType: "getPopularListMovie")
        let params: [String: Any] = try! param.asDictionary()
        return APICaller.makeRequest(url: url, method: .get, paramters: params, header: [:])
    }
}
