//
//  Invite.swift
//  UberRoulette
//
//  Created by Samuel Raudabaugh on 9/19/15.
//  Copyright © 2015 Cornell Tech. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class Invite {
    var userEmail: String?
    var userName: String?
    var inviteeEmail: String?
    var uberId: String?
    
    required init(json: JSON) {
        self.userEmail = json["userEmail"].string
        self.userName = json["userName"].string
        self.inviteeEmail = json["inviteeEmail"].string
        self.uberId = json["uberId"].string
    }
}

/*
var InviteSchema = new mongoose.Schema({
    8     userEmail: String,
    9     fullName: String,
    10     inviteeEmail: String,
    11     note: String,
    12     listOfPlaces: [{
    13         name: String,
    14         latitude: Number,
    15         longitude: Number,
    16         message: String,
    17         category: String
    18     }],
    19     sentAt: { type: Date, default: Date.now }
    20 });
*/

/*
var UserSchema = new mongoose.Schema({
    8     firstName: String,
    9     lastName: String,
    10     email: String,
    11     picture: String,
    12     uberId: String,
    13     listOfPlaces: [{
    14         friendFullName: String,
    15         name: String,
    16         latitude: Number,
    17         longitude: Number,
    18         message: String,
    19         category: String
    20     }],
    21     updatedAt: { type: Date, default: Date.now }
    22 });
*/