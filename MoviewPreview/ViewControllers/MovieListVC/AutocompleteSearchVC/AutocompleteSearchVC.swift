//
//  AutocompleteSearchVC.swift
//  MoviePreview
//
//  Created by Dariusz Mazur on 29/01/2021.
//  Copyright © 2021 eRapid Studio. All rights reserved.
//

import UIKit

class AutocompleteSearchVC: UITableViewController {
    private var lNoMovies: UILabel?
    var filteredResponse = [Movie]()
    weak var movieListParent: MovieListVC? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        AutocompleteSearchCell.registerCell(tableView)
        
        createTopLabel()
        lNoMovies?.isHidden = true
        tableView.sectionHeaderHeight = 1
    }
    
    func updateTopLabel() {
        if filteredResponse.count > 0 {
            lNoMovies?.isHidden = true
            tableView.sectionHeaderHeight = 1
            
        } else {
            lNoMovies?.isHidden = false
            tableView.sectionHeaderHeight = 100
        }
    }
    
    func createTopLabel() {
        if lNoMovies != nil {
            return
        }
        lNoMovies = UILabel(frame: CGRect(x: 10, y: 50, width: view.frame.width, height: 50))
        lNoMovies?.text = "No movies found...".localized
        lNoMovies?.textAlignment = .center
    }
}


// MARK: - UITableViewDataSource

extension AutocompleteSearchVC {
    
    func getValueFor(position: Int) -> Movie? {
        if position < 0 || position >= filteredResponse.count {
            return nil
        }
        return filteredResponse[position]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredResponse.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = AutocompleteSearchCell.create(tableView, indexPath: indexPath)
        if let value = getValueFor(position: indexPath.row) {
            cell.setup(value: value)
        } else {
            cell.setupAsError()
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 41
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let lParent = movieListParent, let movie = getValueFor(position: indexPath.row) {
            lParent.openDetails(movie: movie)
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let movieView = lNoMovies {
            return movieView
        }
        
        createTopLabel()
        return lNoMovies
    }
}
