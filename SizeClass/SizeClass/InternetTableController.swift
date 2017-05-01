//
//  InternetTableController.swift
//  navigation
//
//  Created by Evgeni' Roslik on 21/03/2017.
//  Copyright © 2017 Evgeni' Roslik. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class InternetTableController: UITableViewController {

    
    var objectList = [JsonList]();
    
    var activityIndicator:UIActivityIndicatorView?;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 20, height: 20));
        activityIndicator?.color = UIColor.blue;
        let barButton = UIBarButtonItem(customView: activityIndicator!)
        self.navigation.setRightBarButton(barButton, animated: true)
        
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
    
    @IBOutlet var navigation: UINavigationItem!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.navigationItem.title = "Web List";
        activityIndicator?.startAnimating()
        DispatchQueue.global(qos: .utility).async{
            let semaphore = DispatchSemaphore(value: 0)
            Alamofire.request("https://jsonplaceholder.typicode.com/posts", method: .get).responseString(completionHandler: {response in
                if (response.result.isSuccess)
                {
                    let resultJson = response.result.value!;
                    let json:NSData = (resultJson as NSString).data(using:String.Encoding.utf8.rawValue)! as NSData
                    let parsedJson = JSON(json);
                    for (index, currentJson)in parsedJson
                    {
                        let object = JsonList(userId: currentJson["userId"].int!, id: currentJson["id"].int!,  title: currentJson["title"].string!, body: currentJson["body"].string!);
                        self.objectList.append(object);
                    }
                }
                semaphore.signal();
            })
            semaphore.wait();
            DispatchQueue.main.async(){
                self.table.reloadData();
                self.activityIndicator?.stopAnimating();
            }
        }
    }
    // MARK: - Table view data source


    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return objectList.count;
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! InternetTemplateCell

        // Configure the cell...
        cell.id?.text = String(self.objectList[indexPath.item].id);
        cell.title?.text = self.objectList[indexPath.item].title;
        cell.cellText?.text = self.objectList[indexPath.item].body;
        return cell
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        self.objectList.removeAll();
        self.table.reloadData();
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
