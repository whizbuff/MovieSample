//
//  MovieDetailsPresenter.swift
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

protocol MovieDetailsPresentationLogic
{
  func presentSomething(response: MovieDetails.Something.Response)
}

class MovieDetailsPresenter: MovieDetailsPresentationLogic
{
  weak var viewController: MovieDetailsDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: MovieDetails.Something.Response)
  {
    let viewModel = MovieDetails.Something.ViewModel()
    viewController?.displaySomething(viewModel: viewModel)
  }
}
