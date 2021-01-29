//
//  NowPlayingResponse.swift
//  MoviePreview
//
//  Created by Dariusz Mazur on 29/01/2021.
//  Copyright © 2021 eRapid Studio. All rights reserved.
//

import Foundation
import ObjectMapper


class NowPlayingResponse: APIBaseResponse {
    var results: [Movie] = []
    
    //"maximum": "2016-09-01",
    var dateMinimum: String?
    var dateMaximum: String?

    override func jsonMapper(map: Map) {
        results <- map["results"]
        
        dateMaximum <- map["maximum"]
        dateMinimum <- map["minimum"]
    }
}

