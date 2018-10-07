//
//  MovieListPresenter.swift
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

protocol MovieListPresentationLogic {
    func presentMovies(response: ListMovies.FetchMovies.Response)
    func fetchingMoviesFailed(error: Error)
}

class MovieListPresenter: MovieListPresentationLogic {
    weak var viewController: MovieListDisplayLogic?
    
    // MARK: Movies list
    func presentMovies(response: ListMovies.FetchMovies.Response) {
        var movies: [ListMovies.FetchMovies.ViewModel.Movie] = []
        for movie in response.movies {
            let viewModel = ListMovies.FetchMovies.ViewModel.Movie.init(title: movie.Title, year: movie.Year, poster: movie.Poster)
            movies.append(viewModel)
        }
        
//        let moviesViewModel = ListMovies.FetchMovies.ViewModel.init(movies: movies)
        let moviesViewModel = ListMovies.FetchMovies.ViewModel.init(movies: movies)
        
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.displayMovies(viewModel: moviesViewModel)
        }
    }
    
    func fetchingMoviesFailed(error: Error) {
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.displayError(error: error)
        }
    }
}
