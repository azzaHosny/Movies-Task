//
//  PopularMoviesRequest.swift
//  Movies
//
//  Created by SmartPan on 12/30/21.
//

import Foundation
struct PopularMoviesRequest: Codable {
    let api_key: String
    let language: String
    let page: Int
    let region: String
}
