//
//  AutocompleteSearchCell.swift
//  MoviePreview
//
//  Created by Dariusz Mazur on 29/01/2021.
//  Copyright © 2021 eRapid Studio. All rights reserved.
//

import UIKit

class AutocompleteSearchCell: UITableViewCell {
    @IBOutlet weak var lTitle: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    
    // MARK: creating view

    func setup(value: Movie) {
        lTitle.text = value.title
    }
    
    func setupAsError() {
        lTitle.text = "????"
    }
}

extension AutocompleteSearchCell : TableViewProtocole {
    typealias TableCellType = AutocompleteSearchCell
    
    static func getCellIdentifier() -> String {
        return "AutocompleteSearchCell"
    }
}



