//
//  SearchCell.swift
//  GithubRepoSearcher
//
//  Created by Dariusz Mazur on 25/01/2021.
//  Copyright © 2021 eRapid Studio. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import Async


class MovieListCell: UITableViewCell {
    private static let imgPlaceholder = KFCrossPlatformImage(named: "moviePlaceholder")!
    
    @IBOutlet private weak var lTitle: UILabel!
    @IBOutlet private weak var lLanguage: UILabel!
    @IBOutlet private weak var lReleaseDate: UILabel!
    @IBOutlet private weak var lRate: UILabel!
    @IBOutlet private weak var ivPoster: UIImageView!
    @IBOutlet private weak var btnFavourite: UIButton!
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    
    // MARK: creating view

    public func setup(value: Movie) {
        lTitle.text = value.title
        lLanguage.text = value.originalLanguage
        lReleaseDate.text = value.releaseDate
        lRate.text = value.voteAverage.asString
        
        btnFavourite.tag = value.movieID
        btnFavourite.isSelected = value.isFavourite()
        
        ImageUtils.getImage(urlImage: value.getPosterUrl) { [weak self] (newImage: UIImage?) in
            guard let image = newImage else {
                self?.showPlaceholderImage()
                return
            }
            
            self?.ivPoster.image = image
        }
    }
    
    private func showPlaceholderImage() {
        ivPoster.image = MovieListCell.imgPlaceholder
    }
    
    public func setupAsError() {
        lTitle.text = "???"
        lLanguage.text = "???"
        lReleaseDate.text = "???"
    }
    
    @IBAction func onClickFavourites(_ sender: Any) {
        if btnFavourite.isSelected {
            Movie.setAsUnfavourite(btnFavourite.tag)
            btnFavourite.isSelected = false
            
        } else {
            Movie.setAsFavourite(btnFavourite.tag)
            btnFavourite.isSelected = true
        }
    }
}



extension MovieListCell : TableViewProtocole {
    typealias TableCellType = MovieListCell
    
    static func getCellIdentifier() -> String {
        return "MovieListCell"
    }
}



