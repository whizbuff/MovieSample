//
//  MovieListViewControllerTests.swift
//  MovieSampleTests
//
//  Created by rajesh.rao on 07/10/2018.
//  Copyright © 2018 rajesh.rao. All rights reserved.
//

@testable import MovieSample
import XCTest

class MovieListViewControllerTests: XCTestCase {
    var sut: MovieListViewController!
    
    class MovieListBusinessLogicSpy: MovieListBusinessLogic {
        
        var fetchMoviesWasCalled  = false
        func fetchMovies(searchTerm: String, offset: Int) {
            fetchMoviesWasCalled = true
        }
    }
    
    func testShouldDisplayFetchedMovies()
    {
        // Given
        sut = MovieListViewController.init(nibName: "MovieListViewController", bundle: nil)
        UIApplication.shared.keyWindow!.rootViewController = sut
        _ = sut.view
        RunLoop.current.run(until: Date())
        
        // When
        var movies: [ListMovies.FetchMovies.ViewModel.Movie] = []
        let viewModel = ListMovies.FetchMovies.ViewModel.Movie.init(title: "Test Title", year: "2018", poster: nil)
        movies.append(viewModel)
        let moviesViewModel = ListMovies.FetchMovies.ViewModel.init(movies: movies)
        
        sut.displayMovies(viewModel: moviesViewModel)
        
        let numberOfRows = sut.tableView(sut.tableView, numberOfRowsInSection: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.tableView(sut.tableView, cellForRowAt: indexPath) as! MovieTableViewCell
        
        // Then
        XCTAssert(numberOfRows == 1, "Displaying fetched orders should reload the table view")
        XCTAssert(cell.titleLabel.text == "Test Title", "Title doesnt add up")
        XCTAssert(cell.synopsisLabel.text == "2018", "Year doesnt add up")
    }
}
