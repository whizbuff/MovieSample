//
//  MovieListInteractorTests.swift
//  MovieSampleTests
//
//  Created by rajesh.rao on 07/10/2018.
//  Copyright © 2018 rajesh.rao. All rights reserved.
//

@testable import MovieSample
import XCTest

class MovieListInteractorTests : XCTestCase {
    var sut: MovieListInteractor!
    
    override func setUp()
    {
        super.setUp()
        sut = MovieListInteractor()
    }
    
    class MovieListPresentationLogicSpy: MovieListPresentationLogic
    {
        var presentFetchedMoviesSuccessCalled = false
        var presentFetchedMoviesFailedCalled = false
        
        func presentMovies(response: ListMovies.FetchMovies.Response) {
            presentFetchedMoviesSuccessCalled = true
        }
        
        func fetchingMoviesFailed(error: Error) {
            presentFetchedMoviesFailedCalled = true
        }
    }

    class MovieListWorkerSpy: MovieListWorker
    {
        var fetchMoviesCalled = false
        
        override func fetchMovies(url: URL, completionHandler: @escaping (MovieListStoreResult) -> Void) {
            fetchMoviesCalled = true
            completionHandler(.success(MovieList.init(Search: [], totalResults: "123", Response: "True")))
        }
    }

    // MARK: - Tests

    func testFetchMoviesShouldAskMoviesWorkerToFetchMoviesAndPresenterToFormatResult()
    {
        // Given
        let movieListWorkerSpy = MovieListWorkerSpy()
        sut.worker = movieListWorkerSpy
        var movieListPresentationLogicSpy = MovieListPresentationLogicSpy()
        sut.presenter = movieListPresentationLogicSpy
        
        // When
        sut.fetchMovies(searchTerm: "test", offset: 1)

        // Then
        XCTAssert(movieListWorkerSpy.fetchMoviesCalled, "fetch movies is called")
        XCTAssert(movieListPresentationLogicSpy.presentFetchedMoviesSuccessCalled, "intended fetch movies is called")
        
    }
}
