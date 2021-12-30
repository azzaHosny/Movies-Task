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
    case sucess([MoviesUIViewModel])
    case fail
    case loading
}

class MoviesListViewModel {
    
}
