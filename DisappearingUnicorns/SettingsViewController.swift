//
//  SettingsViewController.swift
//  DisappearingUnicorns
//
//  Created by Chris Chau on 2019-09-25.
//  Copyright © 2019 Chris Chau. All rights reserved.
//

import UIKit
import Foundation

class SettingsViewController: UIViewController, UITextFieldDelegate {
    
    
    var imagePicker = UIImagePickerController()
    @IBOutlet weak var bgSwitch: UISwitch!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet weak var gameSpeedSlider: UISlider!
    @IBOutlet weak var backgroundColorButtons: UISegmentedControl!
    @IBOutlet weak var updateAgeBtn: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var gameSpeedLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    
    var bswitch : Bool = true
    let gameData = GameData()
    let userDefault = UserDefaults.standard
    var sliderDefault: Float!

    
    @IBAction func retrieveGameSpeed(_ sender: Any) {
        var speed = String(format: "%.2f", gameSpeedSlider.value)
        gameSpeedLabel.text = ("(" + speed + " s /round)")
        userDefault.set(Float(speed), forKey: "speed")

    }
    
    
    @IBAction func changeImagePressed(_ sender:
        Any) {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated:true, completion: nil)
        
        // Saving to context
    
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
    @IBAction func updateNameField(_ sender: Any) {

    }

    @IBAction func clearAgeField(_ sender: Any) {
        ageField.placeholder = nil;
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
    
    // Upon press, should update age and name
    @IBAction func updatePressed(_ sender: Any) {
        
        // Closes keyboard
        //ageField.resignFirstResponder()
      //  gameData.savePhoto(profileImage.image!)
        ageField.resignFirstResponder()
        guard let age = Int(ageField.text!) else {
            print("Not updating age")
            return
        }
        userDefault.set(Int(age), forKey: "age")
        self.ageLabel.text = ("age: " + "\(age)")
        // Need to have a popup now
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
        let nameString = NSAttributedString.init(string: "Name", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black])

        let updateAgeString = NSAttributedString.init(string: "Update age here", attributes: [NSAttributedString.Key.foregroundColor : UIColor.darkGray])
        nameField.attributedPlaceholder = nameString
        ageField.attributedPlaceholder = updateAgeString

        // Image picker
        imagePicker.delegate = self
        
        // Setup defaultsx
        sliderDefault = userDefault.float(forKey: "speed")
        let age = userDefault.integer(forKey: "age")
        self.ageLabel.text = ("age: " + "\(age)")
        self.gameSpeedSlider.value = sliderDefault
        self.gameSpeedLabel.text = ("(" + "\(sliderDefault!)" + " s /round)")

    }
    /*
    func hideAgeKeyboard() {
        ageField.resignFirstResponder()
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SettingsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[.editedImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        profileImage.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
}


