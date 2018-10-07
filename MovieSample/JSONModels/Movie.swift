//
//  Movie.swift
//  MovieSample
//
//  Created by rajesh.rao on 06/10/2018.
//  Copyright © 2018 rajesh.rao. All rights reserved.
//

import Foundation

struct Movie: Codable {
    let Title: String
    let Year: String
    let Poster: String?
    let imdbID: String
}

struct MovieList: Decodable {
    let Search: [Movie]
    let totalResults: String
    let Response: String
    
    var movies: [Movie] {
        get {
            return Search
        }
    }
}
