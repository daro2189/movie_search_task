//
//  SearchVC.swift
//  GithubRepoSearcher
//
//  Created by Dariusz Mazur on 25/01/2021.
//  Copyright © 2021 eRapid Studio. All rights reserved.
//

import UIKit
import Foundation

class MovieListVC : UIViewController {
    @IBOutlet weak var mainTable: UITableView!
    
    var selectedIndexPath: IndexPath? = nil
    var dialogLoading: ActivityVC? = nil
    var moviesArray: [Movie] = []
    var totalItems: Int = 0
    var currentPage: Int = 1
    
    var autocompleteSearchVC: AutocompleteSearchVC!
    var searchController: UISearchController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initVC()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        reloadItemAfterGoingBack()
    }
    
    private func initVC() {
        self.title = "Movie Search".localized
        
        MovieListCell.registerCell(mainTable)
        mainTable.delegate = self
        mainTable.dataSource = self
        mainTable.estimatedRowHeight = 101
        
        initSearchController()
        
        //create guest login at start!
        APIController.auth(newDataDel: { [weak self] (MovieListResponse) in
            self?.getNowPlayingMovies()
            
        }) { (String) in }
    }

    
    func openDetails(movie: Movie) {
        if let mv = MovieDetailVC.createDetailVC(model: movie) {
            navigationController?.pushViewController(mv, animated: true)
        }
    }
}
