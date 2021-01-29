//
//  MovieListController.swift
//  MoviePreview
//
//  Created by Dariusz Mazur on 28/01/2021.
//  Copyright © 2021 eRapid Studio. All rights reserved.
//

import Foundation
import Async
import ObjectMapper


extension MovieListVC {
    static let LIST_COUNT_RESPONSE = 20
   
    private func showErrorDialog(message: String) {
        DialogUtils.showOKDialog("", message: message)
    }
    
    func loadNextItems() {
        currentPage += 1
        getNowPlayingMovies()
    }
    
    func getNowPlayingMovies() {
        APIController.nowPlayingMovies(page: currentPage, newDataDel: { [weak self] (response: [Movie], total: Int) in
            self?.totalItems = total
            self?.moviesArray.append(contentsOf: response)
            self?.reloadTableView()
            
        }, errorDel: { [weak self] (errorMsg: String?) in
            if let msg = errorMsg {
                self?.showErrorDialog(message: msg)
            } else {
                self?.showErrorDialog(message: "Our custom error")
            }
        })
    }
    
    func autocompleteForMovies(search: String) {
        APIController.autocompleteSearchMovies(search: search, newDataDel: { [weak self] (response: [Movie]) in
            self?.showAutoCompleteMovies(newMovieList: response)
            
        }, errorDel: { [weak self] (errorMsg: String?) in
            if let msg = errorMsg {
                self?.showErrorDialog(message: msg)
            } else {
                self?.showErrorDialog(message: "Our custom error")
            }
        })
    }
}
