//
//  DetailVM.swift
//  loodos
//
//  Created by Berkay Delen on 20.08.2020.
//

import Foundation

class DetailVM {

    var reloadTableViewClosure: (()->())?

    private var movieData: MovieData? = nil


    func getData() -> MovieData? {
        return movieData ?? nil
    }

    ///API
    func getMovieDetail(movieID:String) {
        APIClient.getMovie(id: movieID,plot: .full, completion: { (success, error, data) in

            self.movieData = data
            self.reloadTableViewClosure?()

            self.addFirebaseLog(logName: "movie_detail_open")
        })
    }

    func addFirebaseLog(logName:String) {
        APIClient.addFirebaseLog(logName: logName, movie: self.movieData!)
    }
    ///API
}
