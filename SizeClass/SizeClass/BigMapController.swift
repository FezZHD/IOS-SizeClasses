//
//  BigMapController.swift
//  map
//
//  Created by Evgeni' Roslik on 4/30/17.
//  Copyright © 2017 Evgeni' Roslik. All rights reserved.
//

import UIKit
import MapKit

class BigMapController: UIViewController,MKMapViewDelegate, UIGestureRecognizerDelegate  {

    @IBOutlet weak var navigation: UINavigationItem!
    var activityIndicator:UIActivityIndicatorView?;
    let weatherService = WeatherService();
    var weatherArray:[WeatherStats]!;
    var regionStartRadius:Double = 1000000;
    let regionRadius: CLLocationDistance = 100000;
    @IBOutlet var map: MKMapView!
    var currentAnnotation:MKPointAnnotation!;
    var annotationArray = [MKPointAnnotation]();
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.activityIndicator?.startAnimating();
        DispatchQueue.global(qos:.utility).async {
            self.weatherService.getWeatherArrayInfo(complitionHandler:{result in
                self.weatherArray = result;
            })
            DispatchQueue.main.async {
                self.activityIndicator?.stopAnimating();
                for weather in self.weatherArray{
                    let annotation = MKPointAnnotation();
                    annotation.coordinate = CLLocationCoordinate2D(latitude: weather.lat, longitude: weather.lon);
                    annotation.title = weather.city;
                    annotation.subtitle = "Current weather is : \(String(format:"%.2f",weather.temp)) °C";
                    self.map.addAnnotation(annotation);
                    self.annotationArray.append(annotation);
                }
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.navigationItem.title = "Map";
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 20, height: 20));
        activityIndicator?.color = UIColor.blue;
        self.activityIndicator?.hidesWhenStopped = true;
        let barButton = UIBarButtonItem(customView: activityIndicator!)
        self.navigation.setRightBarButton(barButton, animated: true)
        let recognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.mapPress(gestureRecognizer:)));
        recognizer.minimumPressDuration = 1;
        recognizer.delaysTouchesBegan = true;
        recognizer.delegate = self;
        map.delegate = self;
        map.addGestureRecognizer(recognizer);
        //map.setRegion(MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2D(latitude: 48, longitude: -100), regionRadius * 2.0, regionRadius * 2.0), animated: true);
        centerMap(location: CLLocation(latitude: 48, longitude: -100), regionValue: regionStartRadius);
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapPress(gestureRecognizer: UILongPressGestureRecognizer){
        if (currentAnnotation != nil){
            map.deselectAnnotation(currentAnnotation, animated: true);
            //map.removeAnnotation(currentAnnotation);
        }
        let location = gestureRecognizer.location(in: map)
        let mapLocation = self.map.convert(location, toCoordinateFrom: map);
        let index = getCorrectCity(mapLocation: mapLocation);
        //currentAnnotation = MKPointAnnotation();
        currentAnnotation = annotationArray[index];
       
        //annotation.coordinate = CLLocationCoordinate2D(latitude: object.lat, longitude: object.lon);
        //currentAnnotation = annotation;
        centerMap(location: CLLocation(latitude: weatherArray[index].lat, longitude: weatherArray[index].lon), regionValue: regionRadius);
        //map.addAnnotation(currentAnnotation);
        map.selectAnnotation(annotationArray[index], animated: true);
        print("tap")
    }
    
    func getCorrectCity(mapLocation:CLLocationCoordinate2D) -> Int{
        var currentIndex:Int!;
        var currentLenght:Double = 0;
        for(index, city) in weatherArray.enumerated(){
            if (index == 0){
                currentLenght = calculateLenght(mapLocation: mapLocation, cityLocation: CLLocationCoordinate2D(latitude: city.lat, longitude: city.lon))
                continue;
            }
            let newLength = calculateLenght(mapLocation: mapLocation, cityLocation: CLLocationCoordinate2D(latitude: city.lat, longitude: city.lon))
            if (newLength < currentLenght){
                currentLenght = newLength;
                currentIndex = index;
            }
        }
        return currentIndex;
    }
    
    
    func calculateLenght(mapLocation:CLLocationCoordinate2D, cityLocation:CLLocationCoordinate2D) -> Double{
        let lat = abs(mapLocation.latitude - cityLocation.latitude);
        let lon = abs(mapLocation.longitude - cityLocation.longitude);
        return sqrt((lat * lat) + (lon * lon));
    }
    
    
    func centerMap(location:CLLocation, regionValue:Double){
        let coordinates = MKCoordinateRegionMakeWithDistance(location.coordinate, regionValue * 2.0, regionValue * 2.0);
        map.setRegion(coordinates, animated: true);
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
