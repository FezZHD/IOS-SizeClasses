//
//  ViewController.swift
//  Converter
//
//  Created by Evgeni' Roslik on 08/03/2017.
//  Copyright © 2017 Evgeni' Roslik. All rights reserved.
//

import UIKit

class ConverterController: UIViewController {

    
    weak var mainNavigation:UINavigationController!;
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Converter";
        // Do any additional setup after loading the view, typically from a nib.
        currencySelector.selectedSegmentIndex = 0;
        currentCurrency = 3.265;
    }
    
    private var currentCurrency :Double!;
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet var resultLabel: UILabel!

    @IBOutlet var valueThird: UILabel!
    @IBOutlet var valueSecond: UILabel!
    @IBOutlet var valueFirst: UILabel!
    @IBOutlet var resultLabelSecond: UILabel!
    @IBOutlet var resultLabelFirst: UILabel!
    @IBOutlet var currencySelector: UISegmentedControl!

    @IBOutlet var enteredValue: UITextField!

    @IBAction func currencyChanged(_ sender: UISegmentedControl) {
    }

    @IBAction func buttonClick(_ sender: Any) {
        var value:Double = 0;
        if (enteredValue.text!.isEmpty){
            value = 1;
        }
        else
        {
            if let temp = Double(enteredValue.text!){
                value = temp;
            }
            else{
                self.present(self.makeAlert(message: "Please, enter correct value"), animated: true, completion: nil);
                return;
            }
        }
        if (value < 0)
        {
            self.present(self.makeAlert(message: "Please, enter positive value"), animated: true, completion: nil);
            return;
        }
        if (value == 0)
        {
            value = 1;
        }
        valueFirst.text = "Byr";
        switch(currencySelector.selectedSegmentIndex)
        {
            case 0:
                valueThird.text = "Eu";
                valueSecond.text = "Us";
                resultLabelFirst.text = convertRu(coefficient: 61, value: value, counter: 1);
                resultLabelSecond.text = convertRu(coefficient: 58.8, value: value, counter: 1);
                resultLabel.text = convertRu(coefficient: 30.6, value: value, counter: 1);
                break;
            case 1:
                valueThird.text = "Ru";
                valueSecond.text = "Us";
                resultLabelFirst.text = convert(coefficient: 1.08, value: value, counter: 1);
                resultLabelSecond.text = convert(coefficient: 61.7, value: value, counter: 1);
                resultLabel.text = convert(coefficient: 2.03, value: value, counter: 1);
                break;
            case 2:
                valueThird.text = "Eu";
                valueSecond.text = "Ru";
                resultLabelFirst.text = convert(coefficient: 57.16, value: value, counter: 1);
                resultLabelSecond.text = convert(coefficient: 0.94, value: value, counter: 1);
                resultLabel.text = convert(coefficient: 1.9, value: value, counter: 1);
                break;
            default:
                break;
        }
    }
    
    func convert(coefficient:Double, value:Double , counter:Double) -> String{
        return String(format:"%.2f", value * coefficient);
    }
    
    func convertRu(coefficient:Double, value:Double , counter:Double) -> String {
        return String(format:"%.2f", value / coefficient);
    }
    
    func makeAlert(message:String) -> UIAlertController {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.alert);
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:nil));
        return alert;
    }
}

