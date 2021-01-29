//
//  SearchMovieResponse.swift
//  MoviePreview
//
//  Created by Dariusz Mazur on 29/01/2021.
//  Copyright © 2021 eRapid Studio. All rights reserved.
//

import Foundation
import ObjectMapper


class SearchMovieResponse: APIBaseResponse {
    var results: [Movie] = []
    
    override func jsonMapper(map: Map) {
        results <- map["results"]
    }
}

