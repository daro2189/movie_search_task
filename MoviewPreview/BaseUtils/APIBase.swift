//
//  APIBase.swift
//  MoviePreview
//
//  Created by Dariusz Mazur on 28/01/2021.
//  Copyright © 2021 eRapid Studio. All rights reserved.
//

import Alamofire


class APIBase {
    
    private static let API_TOKEN = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4ZGU0M2EwMGRlMjQyNDU3YmViZTE1NmJjOTQ2Njk4ZSIsInN1YiI6IjYwMTJmZjk2NDZmMzU0MDAzZWI3ZjcxYSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.d139DskwQvB7gDWo-kOsIkg_8pM5VODeYSIlfLVpUX0"
    
    private static let API_KEY = "8de43a00de242457bebe156bc946698e"
    private static let IMAGE_URL = "https://image.tmdb.org/t/p/"
    private static let SERVER_URL = "https://api.themoviedb.org/3/"
    
    static let AUTHENTICATE = "authentication/guest_session/new"
    static let NOW_PLAYING = "movie/now_playing"
    static let AUTOCOMPLETE_SEARCH = "search/movie"
    
    
    private static func defaultHeaders() -> HTTPHeaders {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(API_TOKEN)",
            "Content-Type": "application/json;charset=utf-8"
        ]
        return headers
    }
    
    internal static func smallImageURL(additional: String) -> String {
        return "\(IMAGE_URL)w185/\(additional)?api_key=\(API_KEY)"
    }
    
    internal static func bigImageURL(additional: String) -> String {
        return "\(IMAGE_URL)w300/\(additional)?api_key=\(API_KEY)"  //w780
    }
    
    internal class func getRequest(url: String, params: [String: Any], successResponse: @escaping ([String : AnyObject]) -> Void, errorResponse: @escaping (String?) -> Void) {
        let requestAF = AF.request(SERVER_URL + url + "?api_key=\(API_KEY)", method: .get, parameters: params, encoding: URLEncoding.default, headers: defaultHeaders()).validate()
        
        requestAF.responseJSON { (response) in
            switch response.result {
            case .success:
                if let JSON = response.value as? [String : AnyObject] {
                    //print("GET JSON: \(JSON)")
                    successResponse(JSON)
                }
                break
                
            case .failure:
                //print("GET JSON: \(response.description)")
                errorResponse("errorMsg")
                break
            }
        }
    }
    
    internal class func postRequest(url: String, params: [String: Any], successResponse: @escaping ([String : AnyObject]) -> Void, errorResponse: @escaping (String?) -> Void) {
        let requestAF = AF.request(SERVER_URL + url + "?api_key=\(API_KEY)", method: .post, parameters: params, encoding: JSONEncoding.default, headers: defaultHeaders()).validate()
        
        requestAF.responseJSON { (response) in
            switch response.result {
            case .success:
                if let JSON = response.value as? [String : AnyObject] {
                    //print("POST JSON: \(JSON)")
                    successResponse(JSON)
                }
                break
                
            case .failure:
                //print("POST JSON: \(response.description)")
                errorResponse("errorMsg")
                break
            }
        }
    }
}
