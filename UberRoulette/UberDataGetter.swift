//
//  UberDataGetter.swift
//  UberRoulette
//
//  Created by Samuel Raudabaugh on 9/19/15.
//  Copyright © 2015 Cornell Tech. All rights reserved.
//

import UIKit
import p2_OAuth2
import SwiftyJSON

class UberDataGetter: NSObject {
    static func getMyProfile(callback: (name: String, email: String) -> Void) {
        var json: JSON!
        let req = startOAuth().request(forURL: NSURL(string: "https://sandbox-api.uber.com/v1/me")!)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(req) { data, response, error in
            if nil != error {
                print(error)
            }
            else {
                json = JSON(data: data!)
                callback(name: json["first_name"].stringValue + " " + json["last_name"].stringValue, email: json["email"].stringValue)
            }
        }
        task.resume()
    }
    
    static func startOAuth() -> OAuth2CodeGrant {
        var oauth2: OAuth2CodeGrant!
        // 1. Create settings dict
        let settings = [
            "client_id": "bKI2_eSBM_pHF2Abz1bHa7VNA9uUqsUM",
            "client_secret": "ogaOYGjBrAMGzvjVk92ip9l09jV8BfNShN-LKqSB",
            "authorize_uri": "https://login.uber.com/oauth/authorize",
            "token_uri": "https://login.uber.com/oauth/token",
            "scope": "profile request",
            "redirect_uris": ["http://localhost:3000/auth/uber/callback"],   // don't forget to register this scheme
            "keychain": true,
            "title": "UberRoulette"  // optional title to show in views
            ] as OAuth2JSON            // the "as" part may or may not be needed
        
        // 2. Instantiate OAuth
        oauth2 = OAuth2CodeGrant(settings: settings)
        oauth2.onAuthorize = { parameters in
            print("Did authorize with parameters: \(parameters)")
        }
        oauth2.onFailure = { error in        // `error` is nil on cancel
            if nil != error {
                print("Authorization went wrong: \(error!.localizedDescription)")
            }
        }
        
        // 3. Authorize
        oauth2.authConfig.authorizeEmbedded = true
        oauth2.authConfig.authorizeContext = self
        oauth2.authorize()
        return oauth2
    }

}
