//
//  TableController.swift
//  map
//
//  Created by Evgeni' Roslik on 19/04/2017.
//  Copyright © 2017 Evgeni' Roslik. All rights reserved.
//

import UIKit

class TableController: UITableViewController {

    weak var mainNavigation:UINavigationController!;
    var activityIndicator:UIActivityIndicatorView?;
    
    var weatherArray = [WeatherStats]();
    
    var weatherService = WeatherService();
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 20, height: 20));
        activityIndicator?.color = UIColor.blue;
        let barButton = UIBarButtonItem(customView: activityIndicator!)
        self.navigation.setRightBarButton(barButton, animated: true)
        table.delegate=self;
        table.dataSource=self;
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBOutlet var table: UITableView!
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
    
    @IBOutlet var navigation: UINavigationItem!
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return weatherArray.count;
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableCell;

        cell.city.text = weatherArray[indexPath.item].city;
        cell.desc.text = weatherArray[indexPath.item].status;
        cell.temp.text = String(format:"%.2f", weatherArray[indexPath.item].temp);
        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if (segue.identifier == "cityPush"){
            let destVC = segue.destination as? MapController;
            destVC?.hidesBottomBarWhenPushed = true;
            let index = self.table.indexPathForSelectedRow?.row;
            destVC?.currentWeather = self.weatherArray[index!];
        }
    }
    
    
    

}
