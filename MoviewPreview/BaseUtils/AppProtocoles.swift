//
//  ViewsProtocoles.swift
//  GithubRepoSearcher
//
//  Created by Dariusz Mazur on 25/01/2021.
//  Copyright © 2021 eRapid Studio. All rights reserved.
//

import UIKit


protocol TableViewProtocole {
    associatedtype TableCellType where TableCellType : UITableViewCell
    
    static func getCellIdentifier() -> String
    
    static func registerCell(_ tableView: UITableView)

    static func create(_ tableView: UITableView, indexPath: IndexPath) -> TableCellType
}


extension TableViewProtocole {

    static func create(_ tableView: UITableView, indexPath: IndexPath) -> TableCellType {
        return tableView.dequeueReusableCell(withIdentifier: getCellIdentifier(), for: indexPath) as! TableCellType
    }
    
    static func registerCell(_ tableView: UITableView) {
        tableView.register(UINib(nibName: getCellIdentifier(), bundle: nil), forCellReuseIdentifier: getCellIdentifier())
    }
}




protocol DetailViewProtocole {
    associatedtype DetailModel
    associatedtype DetailVC where DetailVC: DetailViewProtocole
    
    var detailModel: DetailModel! { set get }
    
    
    static func getDetailViewIdentifier() -> String
    
    static func createDetailVC(model: DetailModel) -> DetailVC?
}

extension DetailViewProtocole {
    
    public static func createDetailVC(model: DetailModel) -> DetailVC? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var detailViewController = storyboard.instantiateViewController(withIdentifier: getDetailViewIdentifier()) as? DetailVC
        detailViewController?.detailModel = model as? Self.DetailVC.DetailModel
        return detailViewController
    }
}
