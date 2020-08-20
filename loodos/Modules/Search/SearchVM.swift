//
//  SearchVM.swift
//  loodos
//
//  Created by Berkay Delen on 19.08.2020.
//

import Foundation
import UIKit


class SearchVM {

    private var page:Int = 1
    private var totalResults:Int = 0

    var reloadCollectionViewClosure: (()->())?
    var searchNotFoundClosure: (()->())?
    var searchNotFoundCloseClosure: (()->())?


    private var cellViewModels: [Search] = [Search]() {
        didSet {
            self.reloadCollectionViewClosure?()
        }
    }

    var numberOfCells: Int {
        return cellViewModels.count
    }


    func clearSearchData() {
        self.totalResults = 0
        self.cellViewModels = []
    }
    func getPage() -> Int {
        return page
    }

    func getTotalResults() -> Int {
        return totalResults
    }

    func getAllCellViewModel() -> [Search] {
        return cellViewModels
    }
    func getCellViewModel(indexPath: IndexPath ) -> Search {
        return cellViewModels[indexPath.row]
    }

    ///API
    func getSearchMovies(page:Int = 1,searchText:String) {
        self.page = page
        
        APIClient.getSearchMovies(page:page,searchText: searchText, completion: { (success, error, data) in
            if (data?.search?.count == 0 && page == 1) || (data?.search == nil && page == 1 ){
                self.searchNotFoundClosure?()
            }

            if data?.search != nil{

                if self.cellViewModels.count == 0 {
                    self.cellViewModels = (data?.search)!
                }else{
                    self.cellViewModels.append(contentsOf: (data?.search)!)
                }

                self.totalResults = Int((data?.totalResults)!) ?? 0
                self.reloadCollectionViewClosure?()
                self.searchNotFoundCloseClosure?()
            }else{
            }

        })

    }
    ///API

}
