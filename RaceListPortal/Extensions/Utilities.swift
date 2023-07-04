//
//  Utilities.swift
//  RaceListPortal
//
//  Created by Nishant Bhardwaj on 29/6/2023.
//

import Foundation
import UIKit
struct Utilities{
    
    static func activityIndicatior(stryle:UIActivityIndicatorView.Style = .large,frame:CGRect? = nil,position:CGPoint?)-> UIActivityIndicatorView{
        let indicator = UIActivityIndicatorView(style: stryle)
        if let indicatorFrame = frame{
            indicator.frame = indicatorFrame
        }
        if let center = position{
            indicator.center = center
        }
        
        return indicator
    }
    
    
    static func getRaceCategoryImage(catetegoryID:raceCategoryID) -> String{
        switch catetegoryID {
        case .Greyhound_race:
            return "greyhound_racing"
        case .Harness_race:
            return "harness_racing"
        case .Horse_race:
            return "horse_racing"
        }
    }
    
}

enum raceCategoryID:String {
    case Greyhound_race = "9daef0d7-bf3c-4f50-921d-8e818c60fe61"
    case Harness_race = "161d9be2-e909-4326-8c2c-35ed71fb460b"
    case Horse_race = "4a2788f8-e825-4d36-9894-efd4baf1cfae"
}

