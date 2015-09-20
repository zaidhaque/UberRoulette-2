//
//  RequestRideViewController.swift
//  UberRoulette
//
//  Created by Samuel Raudabaugh on 9/19/15.
//  Copyright © 2015 Cornell Tech. All rights reserved.
//

import UIKit
import ASValueTrackingSlider

class RequestRideViewController: UIViewController, ASValueTrackingSliderDataSource {
    @IBOutlet weak var costSlider: ASValueTrackingSlider!
    @IBOutlet weak var distanceSlider: ASValueTrackingSlider!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup(costSlider, max: 200.0)
        setup(distanceSlider, max: 50.0)
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

}
