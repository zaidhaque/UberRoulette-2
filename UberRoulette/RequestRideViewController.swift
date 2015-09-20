//
//  RequestRideViewController.swift
//  UberRoulette
//
//  Created by Samuel Raudabaugh on 9/19/15.
//  Copyright © 2015 Cornell Tech. All rights reserved.
//

import UIKit

import Alamofire
import ASValueTrackingSlider
import p2_OAuth2
import SwiftyJSON

class RequestRideViewController: UIViewController, ASValueTrackingSliderDataSource {
    @IBOutlet weak var costSlider: ASValueTrackingSlider!
    @IBOutlet weak var distanceSlider: ASValueTrackingSlider!
    
    var oauth2: OAuth2CodeGrant!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup(costSlider, max: 200.0)
        setup(distanceSlider, max: 0.0)
    }
    
    func setup(slider: ASValueTrackingSlider, max: Float) {
        slider.maximumValue = max
        slider.minimumValue = 1.0
        slider.popUpViewCornerRadius = 12.0
        slider.popUpViewColor = UIColor(hue: 0.55, saturation: 0.8, brightness: 0.9, alpha: 0.7)
        slider.font = UIFont(name: "GillSans-Bold", size: 22)
        slider.textColor = UIColor(hue: 0.55, saturation: 1.0, brightness: 0.5, alpha: 1)
        slider.dataSource = self
    }

    func slider(slider: ASValueTrackingSlider!, stringForValue value: Float) -> String! {
        if slider == costSlider {
            return String.localizedStringWithFormat("$%.2f", value)
        }
        return String.localizedStringWithFormat("%.1f miles", value)
    }
    
    @IBAction func requestPressed(sender: AnyObject) {
        let req = oauth2.request(forURL: NSURL(string: "https://sandbox-api.uber.com/v1/me")!)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(req) { data, response, error in
            if nil != error {
                print(error)
            }
            else {
                let json = JSON(data: data!)
                
                // Send to uberroulette server
                let parameters: [String:AnyObject] = [
                    "accessToken": self.oauth2.accessToken!,
                    "uberId": json["uuid"].stringValue,
                    "firstName": json["first_name"].stringValue,
                    "lastName": json["last_name"].stringValue,
                    "email": json["email"].stringValue,
                    "picture": json["picture"].stringValue,
                    "start_latitude": 40,
                    "start_longitude": -50,
                    "max_dollar": self.costSlider.value,
                    "max_radius": self.distanceSlider.value
                ]
                
                Alamofire.request(.POST, "http://10.128.1.19:3000/ride", parameters: parameters, encoding: .JSON)
                    .responseString { _, _, result in
                        print("Success: \(result.isSuccess)")
                        print("Response String: \(result.value)")
                        if result.isSuccess {
                            // advance to map screen
                        }
                }
            }
        }
        task.resume()
    }


}
