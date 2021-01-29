//
//  MovieListVC_Search.swift
//  MoviePreview
//
//  Created by Dariusz Mazur on 29/01/2021.
//  Copyright © 2021 eRapid Studio. All rights reserved.
//

import UIKit


extension MovieListVC : UISearchBarDelegate, UISearchResultsUpdating {
     
    func initSearchController() {
        autocompleteSearchVC = storyboard?.instantiateViewController(withIdentifier: "AutocompleteSearchVC") as? AutocompleteSearchVC
        autocompleteSearchVC.movieListParent = self
        
        searchController = UISearchController(searchResultsController: autocompleteSearchVC)
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.autocapitalizationType = .none
        searchController.dimsBackgroundDuringPresentation = false
        
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search for movies...".localized
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func showAutoCompleteMovies(newMovieList: [Movie]) {
        if let resultVC = searchController.searchResultsController as? AutocompleteSearchVC {
            resultVC.filteredResponse = newMovieList
            resultVC.updateTopLabel()
            resultVC.tableView.reloadData()
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let search = searchController.searchBar.text {
            autocompleteForMovies(search: search)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension MovieListVC: UISearchControllerDelegate {
    
    func presentSearchController(_ searchController: UISearchController) {
        //Swift.debugPrint("UISearchControllerDelegate invoked method: \(#function).")
    }
    
    func willPresentSearchController(_ searchController: UISearchController) {
        //Swift.debugPrint("UISearchControllerDelegate invoked method: \(#function).")
    }
    
    func didPresentSearchController(_ searchController: UISearchController) {
        //Swift.debugPrint("UISearchControllerDelegate invoked method: \(#function).")
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
        //Swift.debugPrint("UISearchControllerDelegate invoked method: \(#function).")
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        //Swift.debugPrint("UISearchControllerDelegate invoked method: \(#function).")
    }
}
