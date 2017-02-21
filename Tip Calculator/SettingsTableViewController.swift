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

    @IBOutlet weak var defaultPercentagePicker: UIPickerView!
    
    var pickerData: [String] = [String]()
    
    
    @IBOutlet weak var percentageLabel: UILabel!
    
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        tapGesture.cancelsTouchesInView = false
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        defaultPercentagePicker.delegate = self
        defaultPercentagePicker.dataSource = self
        defaultPercentagePicker.alpha = 0
        
        pickerData = ["18%", "20%", "25%"]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let defaults = UserDefaults.standard
        let intValue = defaults.integer(forKey: "defaultPercentage")
        
        defaultPercentagePicker.selectRow(intValue, inComponent: 0, animated: false)
        percentageLabel.text = pickerData[intValue]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
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
        self.percentageLabel.text = self.pickerData[row]
        UIView.animate(withDuration: SettingsTableViewController.animationTime, animations: {
            self.defaultPercentagePicker.alpha = 0
        })
        
        let defaults = UserDefaults.standard
        defaults.set(row, forKey: "defaultPercentage")
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section == 0) {
            UIView.animate(withDuration: SettingsTableViewController.animationTime, animations: {
                self.defaultPercentagePicker.alpha = 1
            })
        }
    }


    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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

    @IBAction func dismissPickers(_ sender: Any) {
        UIView.animate(withDuration: SettingsTableViewController.animationTime, animations: {
            self.defaultPercentagePicker.alpha = 0
        })
    }
}
