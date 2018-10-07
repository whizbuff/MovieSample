//
//  MovieDetailsInteractor.swift
//  MovieSample
//
//  Created by rajesh.rao on 07/10/2018.
//  Copyright (c) 2018 rajesh.rao. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol MovieDetailsBusinessLogic {
    func getMovieDetails()
}

protocol MovieDetailsDataStore {
    var movie: Movie! { get set }
}

class MovieDetailsInteractor: MovieDetailsBusinessLogic, MovieDetailsDataStore {
    var presenter: MovieDetailsPresentationLogic?
    var worker: MovieDetailsWorker?
    var movie: Movie!
    
    // MARK: Do something
    
    func getMovieDetails() {
        let url = "http://www.omdbapi.com/?i=\(movie.imdbID)&apikey=9e255b1a"
        guard let queryEncodedString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let requestURL = URL(string:queryEncodedString) else {
                return
        }
        let defaultSession = URLSession(configuration: .default)
        let dataTask = defaultSession.dataTask(with: requestURL) { [weak self] (data, response, error) in
            if let error = error {
                self?.presenter?.presentError(error: error)
            } else if let _ = data, let netWorkResponse = response as? HTTPURLResponse, netWorkResponse.statusCode == 200 {
                var movieMetaData: MovieMetaData
                do {
                    let decoder = JSONDecoder()
                    movieMetaData = try decoder.decode(MovieMetaData.self, from: data!)
                    self?.presenter?.presentMovieDetails(response: MovieDetails.MetaData.Response(movieMetaData: movieMetaData))
                }  catch let error {
                    self?.presenter?.presentError(error: error)
                }
            }
        }
        dataTask.resume()
    }
}
