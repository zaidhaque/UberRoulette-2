//
//  RequestRideViewController.swift
//  UberRoulette
//
//  Created by Samuel Raudabaugh on 9/19/15.
//  Copyright © 2015 Cornell Tech. All rights reserved.
//

import UIKit
import ASValueTrackingSlider

class RequestRideViewController: UIViewController {
    @IBOutlet weak var costSlider: ASValueTrackingSlider!
    @IBOutlet weak var distanceSlider: ASValueTrackingSlider!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        costSlider.maximumValue = 200.0
        costSlider.minimumValue = 1.0
        costSlider.popUpViewCornerRadius = 12.0
        costSlider.setMaxFractionDigitsDisplayed(0)
        costSlider.popUpViewColor = UIColor(hue: 0.55, saturation: 0.8, brightness: 0.9, alpha: 0.7)
        costSlider.font = UIFont(name: "GillSans-Bold", size: 22)
        costSlider.textColor = UIColor(hue: 0.55, saturation: 1.0, brightness: 0.5, alpha: 1)
        
        distanceSlider.maximumValue = 50.0
        distanceSlider.minimumValue = 1.0
        distanceSlider.popUpViewCornerRadius = 12.0
        distanceSlider.setMaxFractionDigitsDisplayed(0)
        distanceSlider.popUpViewColor = UIColor(hue: 0.55, saturation: 0.8, brightness: 0.9, alpha: 0.7)
        distanceSlider.font = UIFont(name: "GillSans-Bold", size: 22)
        distanceSlider.textColor = UIColor(hue: 0.55, saturation: 1.0, brightness: 0.5, alpha: 1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
