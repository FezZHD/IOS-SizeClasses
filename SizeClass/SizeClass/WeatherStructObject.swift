//
//  WeatherStructObject.swift
//  map
//
//  Created by Evgeni' Roslik on 19/04/2017.
//  Copyright © 2017 Evgeni' Roslik. All rights reserved.
//

import Foundation

public struct WeatherStats{

    public var city:String;
    public var status:String;
    public var temp:Double;
    public var lon:Double;
    public var lat:Double;
    
    init(city:String, status:String, temp:Double, lon:Double, lat:Double) {
        
        self.city = city;
        self.status = status;
        self.temp = temp - 273.15;
        self.lon = lon;
        self.lat = lat;
    }
}
