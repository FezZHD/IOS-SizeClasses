//
//  MapController.swift
//  map
//
//  Created by Evgeni' Roslik on 4/30/17.
//  Copyright © 2017 Evgeni' Roslik. All rights reserved.
//

import UIKit
import MapKit

class MapController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var mapView: MKMapView!
    let regionRadius: CLLocationDistance = 100000;
    var currentWeather:WeatherStats!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar?.title = self.currentWeather.city;
        let currentLocation = CLLocation(latitude: self.currentWeather.lat, longitude: self.currentWeather.lon);
        centerMap(location: currentLocation);
        let annotation = MKPointAnnotation();
        annotation.title = self.currentWeather.city;
        annotation.subtitle = "Current weather is : \(String(format:"%.2f",self.currentWeather.temp)) °C"
        annotation.coordinate = CLLocationCoordinate2D(latitude: self.currentWeather.lat, longitude: self.currentWeather.lon)
        mapView.delegate = self;
        mapView.addAnnotation(annotation);
        mapView.selectAnnotation(annotation, animated: true);
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func centerMap(location:CLLocation){
        let coordinates = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0);
        mapView.setRegion(coordinates, animated: true);
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
