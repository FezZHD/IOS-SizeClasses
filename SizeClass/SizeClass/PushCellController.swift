//
//  PushCellController.swift
//  navigation
//
//  Created by Evgeni' Roslik on 06/04/2017.
//  Copyright © 2017 Evgeni' Roslik. All rights reserved.
//

import UIKit

class PushCellController: UIViewController {



    
    
    @IBOutlet var navigationBar: UINavigationItem!
    
    public var navigationTitle:String = String();
    public var uri:String = String();
    public var pictureName:String = String();
    public var desc:String = String();
    @IBOutlet var name: UILabel!
    @IBOutlet var longDesc: UILabel!
    @IBOutlet var image: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.name?.text = pictureName;
        self.longDesc?.text = desc;
        self.image?.image = UIImage(named: uri);
        self.navigationBar?.title = navigationTitle;
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
