//
//  APIBaseResponses.swift
//  MoviePreview
//
//  Created by Dariusz Mazur on 28/01/2021.
//  Copyright © 2021 eRapid Studio. All rights reserved.
//

import Foundation
import ObjectMapper

class APIBaseResponse {

    func printInfo() {
        //print("SUCCESS \(success)\nCODE \(statusCode?.description ?? "")\nMESSAGE \(statusMessage ?? "")\nEXPIRE \(expiresAt ?? "")\nSESSIONID \(guestSessionId ?? "")")
    }
    
    private var success: Bool = false
    var isSuccess: Bool {
        get {
            if success {
                return true
            }
            return false
        }
    }
    
    private var statusMessage: String?
    private var statusCode: Int?
    var errorMessage: String? {
        get {
            if isSuccess {
                return nil
            }
            
            if let errMsg = statusMessage {
                return errMsg
            }
            
            return "default error msg"
        }
    }
    
    var expiresAt: String?
    var guestSessionId: String?
    var sessionID: String? {
        get {
            if let sId = guestSessionId {
                return sId
            }
            
            //need to relogin!!!
            return nil
        }
    }
    
    var page: Int = 1
    var totalResults: Int = 1
    var totalPages: Int = 1

    required init?(map: Map) {
        mapping(map: map)
    }
    
    func jsonMapper(map: Map) { }
}

extension APIBaseResponse: Mappable {
    
    func mapping(map: Map) {
        expiresAt <- map["expires_at"]
        guestSessionId <- map["guest_session_id"]
        statusCode <- map["status_code"]
        statusMessage <- map["status_message"]
        success <- map["success"]
        
        page <- map["page"]
        totalResults <- map["total_results"]
        totalPages <- map["total_pages"]
        
        jsonMapper(map: map)
    }
}
