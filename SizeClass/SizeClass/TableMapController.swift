//
//  TableMapController.swift
//  SizeClass
//
//  Created by Evgeni' Roslik on 5/3/17.
//  Copyright © 2017 Evgeni' Roslik. All rights reserved.
//

import UIKit
import MapKit

class TableMapController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    
    var activityIndicator:UIActivityIndicatorView?;
    
    @IBOutlet weak var table: UITableView!
    var weatherArray = [WeatherStats]();
    
    
    var weatherService = WeatherService();
    override func viewDidLoad() {
        super.viewDidLoad();
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 20, height: 20));
        activityIndicator?.color = UIColor.blue;
        let barButton = UIBarButtonItem(customView: activityIndicator!)
        self.tabBarController?.navigationItem.setRightBarButton(barButton, animated: true)
        table.rowHeight = 100;
        table.delegate = self;
        table.dataSource = self;
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        tabBarController?.navigationItem.title = "City List";
        activityIndicator?.startAnimating();
        DispatchQueue.global(qos: .utility).async {
            
            self.weatherService.getWeatherArrayInfo(){result in
                self.weatherArray = result;
                DispatchQueue.main.async {
                    self.activityIndicator?.stopAnimating();
                    self.table.reloadData();
                };
            }
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "cityPush"){
            let destVC = segue.destination as? MapController;
            destVC?.hidesBottomBarWhenPushed = true;
            let index = self.table.indexPathForSelectedRow?.row;
            destVC?.currentWeather = self.weatherArray[index!];
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableCell;
        
        cell.city.text = weatherArray[indexPath.item].city;
        cell.desc.text = weatherArray[indexPath.item].status;
        cell.temp.text = String(format:"%.2f", weatherArray[indexPath.item].temp);
        // Configure the cell...
        
        return cell
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if (UIDevice.current.orientation.isLandscape){
            return false;
        }else{
            return true;
        }
    }
    
}
