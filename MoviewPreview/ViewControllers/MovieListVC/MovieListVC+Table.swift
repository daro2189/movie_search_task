//
//  MovieListVC_Table.swift
//  MoviePreview
//
//  Created by Dariusz Mazur on 28/01/2021.
//  Copyright © 2021 eRapid Studio. All rights reserved.
//

import UIKit

extension MovieListVC : UITableViewDelegate, UITableViewDataSource {
    
    func reloadTableView() {
        mainTable.reloadData()
    }
    
    func reloadItemAfterGoingBack() {
        if let index = selectedIndexPath {
            mainTable.reloadRows(at: [index], with: .automatic)
        }
        selectedIndexPath = nil
    }
    
    func getValueFor(position: Int) -> Movie? {
        if position < 0 || position >= moviesArray.count {
            return nil
        }
        return moviesArray[position]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MovieListCell.create(tableView, indexPath: indexPath)
        if let value = getValueFor(position: indexPath.row) {
            cell.setup(value: value)
        } else {
            cell.setupAsError()
        }
        
        //pagination
        if indexPath.row == moviesArray.count - 2 {
            if totalItems > moviesArray.count && currentPage * MovieListVC.LIST_COUNT_RESPONSE == moviesArray.count { // more items to fetch
                loadNextItems()
            }
        }
        
        return cell
    }
 
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 101
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if let value = getValueFor(position: indexPath.row) {
            selectedIndexPath = indexPath
            openDetails(movie: value)

        } else {
            //here we can print error or so
            DialogUtils.showOKDialog("Error occured", message: "")
        }
    }
}

