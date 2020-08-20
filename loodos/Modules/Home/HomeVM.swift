//
//  HomeVM.swift
//  loodos
//
//  Created by Berkay Delen on 19.08.2020.
//

import UIKit
import Foundation

class HomeVM {


    
    var reloadTableViewClosure: (()->())?




    private var cellHeaderData: MovieData? = nil

    private var cellViewModels: [MovieData] = [MovieData]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    private var cellPopularMovies: [MovieData] = [MovieData]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }


    var numberOfCells: Int {
        return cellViewModels.count
    }

    func getHeaderData() -> MovieData? {
        return cellHeaderData
    }
    func getAllViewModelData() -> [MovieData] {
        return cellViewModels
    }
    func getAllPopularMovieData() -> [MovieData] {
        return cellPopularMovies
    }

    func getCellViewModel( at indexPath: IndexPath ) -> MovieData {
        return cellViewModels[indexPath.row]
    }

    ///API
    func getHeaderMovie() {
        APIClient.getNewMovies { (success, error, data) in
            self.cellViewModels = data!
        }
    }
    func getNewMovies() {
        APIClient.getMovie(id: Constants.Data.headerMovie, completion: { (success, error, data) in
            self.cellHeaderData = data
        })
    }
    func getPopularMovies() {
        APIClient.getPopularMovies { (success, error, data) in
            self.cellPopularMovies = data!
        }
    }
    ///API
}
