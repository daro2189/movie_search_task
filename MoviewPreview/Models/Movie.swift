//
//  Movie.swift
//  MoviePreview
//
//  Created by Dariusz Mazur on 29/01/2021.
//  Copyright © 2021 eRapid Studio. All rights reserved.
//

import Foundation
import ObjectMapper


class Movie {
    var movieID: Int = -1
    private var posterPath: String?
    var getPosterUrl: String {
        get {
            if let img = posterPath {
                return APIBase.smallImageURL(additional: img)
            }
            return ""
        }
    }
    
    var overview: String?
    var releaseDate: String?
    var voteAverage: Float = 0
    
    var originalTitle: String?
    var originalLanguage: String?
    var title: String?
    var backdropPath: String?
    var getDetailImageUrl: String {
        get {
            if let img = backdropPath {
                return APIBase.bigImageURL(additional: img)
            }
            return ""
        }
    }
    
    init() { }
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    

    static func getFavKey(_ movID: Int) -> String {
        return "fav_mv_\(movID)"
    }
    
    func isFavourite() -> Bool {
        return UserDefaults.standard.bool(forKey: Movie.getFavKey(movieID))
    }
    
    func setAsFavourite() {
        Movie.setAsFavourite(movieID)
    }
    
    func setAsUnfavourite() {
        Movie.setAsUnfavourite(movieID)
    }
    
    static func setAsFavourite(_ movID: Int) {
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: Movie.getFavKey(movID))
        defaults.synchronize()
    }
    
    static func setAsUnfavourite(_ movID: Int) {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: Movie.getFavKey(movID))
        defaults.synchronize()
    }
}

extension Movie: Mappable {
    
    func mapping(map: Map) {
        movieID <- map["id"]
        posterPath <- map["poster_path"]
        overview <- map["overview"]
        releaseDate <- map["release_date"]
        originalTitle <- map["original_title"]
        originalLanguage <- map["original_language"]
        originalLanguage = originalLanguage?.uppercased()
        
        title <- map["title"]
        voteAverage <- map["vote_average"]
        backdropPath <- map["backdrop_path"]
    }
}
