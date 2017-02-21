//
//  SettingsTableViewController.swift
//  Tip Calculator
//
//  Created by Martin Sjoelin on 2/20/17.
//  Copyright © 2017 Martin Sjoelin. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    static let animationTime = 0.2

    @IBOutlet weak var picker: UIPickerView!
    
    @IBOutlet weak var percentageLabel: UILabel!
    
    @IBOutlet weak var colorLabel: UILabel!
    
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    
    let pickerPercentageData: [String] = ["18%", "20%", "25%"]
    let pickerBackgroundColorData: [String] = ["White", "Blue/Green", "Purple", "Yellow", "Green", "Red", "Blue"]
    var currentSection = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        tapGesture.cancelsTouchesInView = false
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        picker.delegate = self
        picker.dataSource = self
        picker.alpha = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let defaults = UserDefaults.standard
        let tipPercentage = defaults.integer(forKey: "defaultPercentage")
        
        percentageLabel.text = pickerPercentageData[tipPercentage]
    
        let backgroundColor = defaults.integer(forKey: "defaultBackgroundColor")
        colorLabel.text = pickerBackgroundColorData[backgroundColor]
        updateBackgroundColor(intColor: backgroundColor)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch currentSection {
        case 0:
            return pickerPercentageData.count
        case 1:
            return pickerBackgroundColorData.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch currentSection {
        case 0:
            return pickerPercentageData[row]
        case 1:
            return pickerBackgroundColorData[row]
        default:
            return ""
        }
    }
    
    
    // MARK: - Picker view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        UIView.animate(withDuration: SettingsTableViewController.animationTime, animations: {
            self.picker.alpha = 0
        })
        
        if (currentSection == 0) {
            self.percentageLabel.text = self.pickerPercentageData[row]

            let defaults = UserDefaults.standard
            defaults.set(row, forKey: "defaultPercentage")
        }
        else if (currentSection == 1) {
            self.colorLabel.text = self.pickerBackgroundColorData[row]
            updateBackgroundColor(intColor: row)
            
            let defaults = UserDefaults.standard
            defaults.set(row, forKey: "defaultBackgroundColor")
        }
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
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentSection = indexPath.section
        
        picker.reloadAllComponents()
        
        if (currentSection == 0) {
            let defaults = UserDefaults.standard
            let tipPercentage = defaults.integer(forKey: "defaultPercentage")
            
            picker.selectRow(tipPercentage, inComponent: 0, animated: false)
        }
        else if (currentSection == 1) {
            let defaults = UserDefaults.standard
            let backgroundColor = defaults.integer(forKey: "defaultBackgroundColor")
            
            picker.selectRow(backgroundColor, inComponent: 0, animated: false)
        }
        
        UIView.animate(withDuration: SettingsTableViewController.animationTime, animations: {
            self.picker.alpha = 1
        })
    }


    @IBAction func dismissPickers(_ sender: Any) {
        UIView.animate(withDuration: SettingsTableViewController.animationTime, animations: {
            self.picker.alpha = 0
        })
    }
}
