//
//  ViewController.swift
//  Tip Calculator
//
//  Created by Martin Sjoelin on 2/19/17.
//  Copyright © 2017 Martin Sjoelin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tipLabel: UILabel!
    
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var billField: UITextField!
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let defaults = UserDefaults.standard
        let intValue = defaults.integer(forKey: "defaultPercentage")
        tipControl.selectedSegmentIndex = intValue
        calculateTip()
        
        billField.becomeFirstResponder()
        
        let backgroundColor = defaults.integer(forKey: "defaultBackgroundColor")
        updateBackgroundColor(intColor: backgroundColor)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func billUpdated(_ sender: Any) {
        calculateTip()
    }

    @IBAction func tipUpdated(_ sender: Any) {
        calculateTip()
    }
    
    func calculateTip() {
        let tipPercentages = [0.18, 0.2, 0.25]
        
        let bill = Double(billField.text!) ?? 0
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
    
    func updateBackgroundColor(intColor: Int) {
        switch intColor {
        case 1:
            self.view.backgroundColor = UIColor.localBlueGreen()
        case 2:
            self.view.backgroundColor = UIColor.localPurple()
        case 3:
            self.view.backgroundColor = UIColor.localYellow()
        case 4:
            self.view.backgroundColor = UIColor.localGreen()
        case 5:
            self.view.backgroundColor = UIColor.localRed()
        case 6:
            self.view.backgroundColor = UIColor.localBlue()
        default:
            self.view.backgroundColor = UIColor.white
        }
    }
    
}

