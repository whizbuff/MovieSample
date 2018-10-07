//
//  MovieListInteractor.swift
//  MovieSample
//
//  Created by rajesh.rao on 06/10/2018.
//  Copyright (c) 2018 rajesh.rao. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol MovieListBusinessLogic {
    func fetchMovies(searchTerm: String, offset: Int)
}

protocol MovieListDataStore {
    var movies: [Movie]? { get }
}

class MovieListInteractor: MovieListBusinessLogic, MovieListDataStore {
    var presenter: MovieListPresentationLogic?
    var dataTask: URLSessionDataTask?
    var searchMapping:[String:Int] = [:]
    var worker: MovieListWorker?
    var movies: [Movie]? = []
    
    func pageOffet(_ moviesCount: Int) -> Int {
        return moviesCount/10 + 1
    }
    
    // MARK: fetch movies
    func fetchMovies(searchTerm: String, offset: Int) {
        if let currentPageOffset = searchMapping[searchTerm], currentPageOffset <= offset {
            return
        }
       
        let pageOffset = pageOffet(offset)
        //TODO: move end point
        let url = "http://www.omdbapi.com/?s=\(searchTerm)&page=\(pageOffset)&apikey=9e255b1a"
        guard let queryEncodedString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let requestURL = URL(string:queryEncodedString) else {
            return
        }
        
        worker?.fetchMovies(url: requestURL, completionHandler: { [weak self] (movieListResult) in
            switch movieListResult {
            case .success(let movieList):
                    self?.searchMapping[searchTerm] = Int(movieList.totalResults)
                    let response = ListMovies.FetchMovies.Response(movies: movieList.movies)
                    if pageOffset == 0  {
                        self?.movies = movieList.movies
                    } else {
                        self?.movies?.append(contentsOf: movieList.movies)
                    }
                    self?.presenter?.presentMovies(response: response)
            case .failure(let error):
                    self?.presenter?.fetchingMoviesFailed(error: error)
            }
        })
    }
}
