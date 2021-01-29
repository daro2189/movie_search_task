//
//  MovieDetailVC.swift
//  MoviePreview
//
//  Created by Dariusz Mazur on 29/01/2021.
//  Copyright © 2021 eRapid Studio. All rights reserved.
//

import UIKit
import Kingfisher

class MovieDetailVC: UIViewController, DetailViewProtocole {
    private static let imgPlaceholder = KFCrossPlatformImage(named: "moviePlaceholder")!
    private static let starNormal = KFCrossPlatformImage(named: "starNormal")!
    private static let starSelected = KFCrossPlatformImage(named: "starSelected")!
    
    typealias DetailModel = Movie
    typealias DetailVC = MovieDetailVC
    var detailModel: Movie! = Movie()
    
    @IBOutlet private weak var lRate: UILabel!
    @IBOutlet private weak var lTitle: UILabel!
    @IBOutlet private weak var lDescript: UITextView!
    @IBOutlet private weak var lDate: UILabel!
    @IBOutlet private weak var ivPoster: UIImageView!
    @IBOutlet private weak var ivIsFavourite: UIImageView!
    
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
    }
    
    private func updateStarVisibility() {
        if detailModel.isFavourite() {
            ivIsFavourite.isHidden = false
            navigationItem.rightBarButtonItem?.image = MovieDetailVC.starSelected
            
        } else {
            ivIsFavourite.isHidden = true
            navigationItem.rightBarButtonItem?.image = MovieDetailVC.starNormal
        }
    }
    
    private func initView() {
        self.title = "Details".localized
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: MovieDetailVC.starNormal, style: .plain, target: self, action: #selector(onClickAddToFavourites))
        updateStarVisibility()
        
        lTitle.text = detailModel.title
        lDescript.text = detailModel.overview
        lDate.text = detailModel.releaseDate
        lRate.text = detailModel.voteAverage.asString
        
        ivPoster.image = MovieDetailVC.imgPlaceholder
        ImageUtils.getImage(urlImage: detailModel.getDetailImageUrl) { [weak self] (newImage: UIImage?) in
            guard let image = newImage else {
                self?.ivPoster.image = MovieDetailVC.imgPlaceholder
                return
            }
            self?.ivPoster.image = image
        }
    }
    
    @objc func onClickAddToFavourites(sender: AnyObject) {
        if detailModel.isFavourite() {
            detailModel.setAsUnfavourite()
        } else {
            detailModel.setAsFavourite()
        }
        updateStarVisibility()
    }
    
    static func getDetailViewIdentifier() -> String {
        return "MovieDetailVC"
    }
}
