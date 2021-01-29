//
//  APIController.swift
//  GithubRepoSearcher
//
//  Created by Dariusz Mazur on 25/01/2021.
//  Copyright © 2021 eRapid Studio. All rights reserved.
//

import Foundation
import Alamofire
import Async

class APIController: APIBase {
 
    static func auth(newDataDel: @escaping (APIBaseResponse) -> Void, errorDel: @escaping (String?) -> Void) {
        APIBase.postRequest(url: APIBase.AUTHENTICATE, params: [:], successResponse: { (JSON) in
            if let response = APIBaseResponse(JSON: JSON) {
                response.printInfo()
                newDataDel(response)
                
            } else {
                errorDel("Error in parsing response!")
            }

        }, errorResponse: errorDel)
    }

    static func nowPlayingMovies(page: Int, newDataDel: @escaping ([Movie], Int) -> Void, errorDel: @escaping (String?) -> Void) {
        let params : [String: Any] = [
            "page" : page
        ]

        APIBase.getRequest(url: APIBase.NOW_PLAYING, params: params, successResponse: { (JSON) in
            Async.background { () in
                if let rData = NowPlayingResponse(JSON: JSON) {
                    Async.main { () in
                        newDataDel(rData.results, rData.totalResults)
                    }
                    
                } else {
                    Async.main { () in
                        errorDel("Error in parsing response!")
                    }
                }
            }
        }, errorResponse: errorDel)
    }
    
    static func autocompleteSearchMovies(search: String, page: Int = 1, newDataDel: @escaping ([Movie]) -> Void, errorDel: @escaping (String?) -> Void) {
        
        if search.count < 1 {
            //show response after 1!
            return
        }
        
        let params : [String: Any] = [
            "query" : search,
            "page" : page
        ]

        APIBase.getRequest(url: APIBase.AUTOCOMPLETE_SEARCH, params: params, successResponse: { (JSON) in
            Async.background { () in
                if let rData = SearchMovieResponse(JSON: JSON) {
                    Async.main { () in
                        newDataDel(rData.results)
                    }
                    
                } else {
                    Async.main { () in
                        errorDel("Error in parsing response!")
                    }
                }
            }
        }, errorResponse: errorDel)
    }
}
