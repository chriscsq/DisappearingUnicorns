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
        
    var bswitch : Bool = true
    let gameData = GameData()
    
    // Upon press, should update age and name
    @IBAction func updatePressed(_ sender: Any) {
        
        // Closes keyboard
        ageField.resignFirstResponder()
    }
    
    @IBAction func retrieveGameSpeed(_ sender: Any) {
        
        gameSpeedLabel.text = ("(" + String(format: "%.2f", gameSpeedSlider.value) + " s /round)")
   
    }
    
    
    @IBAction func changeImagePressed(_ sender:
        Any) {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated:true, completion: nil)
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
        // Image picker
        imagePicker.delegate = self
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

extension SettingsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[.editedImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        profileImage.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
}


