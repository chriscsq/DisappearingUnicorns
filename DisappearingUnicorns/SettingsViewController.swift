//
//  SettingsViewController.swift
//  DisappearingUnicorns
//
//  Created by Chris Chau on 2019-09-25.
//  Copyright © 2019 Chris Chau. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var bgSwitch: UISwitch!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet weak var gameSpeedSlider: UISlider!
    @IBOutlet weak var backgroundColorButtons: UISegmentedControl!
    @IBOutlet weak var updateAgeBtn: UIButton!
    
    var bswitch : Bool = true
    let gameData = GameData()
    // Upon press, should update age and name
    @IBAction func updatePressed(_ sender: Any) {
        
        ageField.resignFirstResponder()

    }
    
    @IBAction func donePressed(_ sender: UIBarButtonItem) {
    }
    @IBAction func isSwitchToggled(_ sender: UISwitch) {
        if sender.isOn {
            bgSwitch.setOn(false, animated:true)
            bswitch = true
        } else {
            bgSwitch.setOn(false, animated:true)
            bswitch = false
        }
    }
    
    // getter for namefield
    func getName() -> String {
        //let nameText: String! = nameField.text!
        //print(nameText)
       // print(nameField.text)
        return "testing"
    }
    
    /*
    @IBAction func isSwitchToggled(_ sender: UISwitch) {
        if sender.isOn {
            backgroundSwitch.setOn(false, animated:true)
            bswitch = true
        } else {
            backgroundSwitch.setOn(false, animated:true)
            bswitch = false
        }
    }
    */
    
    // Segmented control
    @IBAction func changeBackground(_ sender: Any) {
        /*
        if bswitch {
            switch backgroundColorButtons.selectedSegmentIndex {
            case 0:
                print("red")
            case 1:
                print("blue")
            case 3:
                print("green")
            case 4:
                print("yellow")
            default:
                break
            }
        } else {
            print("Switch is off")
        }
        */
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        updateAgeBtn.layer.cornerRadius = 5
        updateAgeBtn.clipsToBounds = true
        // Do any additional setup after loading the view.
        bgSwitch.addTarget(self, action: #selector(isSwitchToggled), for: .valueChanged)
        
        // For text field
        self.nameField.delegate = self
        self.ageField.delegate = self
        doneButton.tintColor = UIColor.red
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
