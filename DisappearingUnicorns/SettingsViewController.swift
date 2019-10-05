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
    @IBOutlet weak var bgCircle: UIImageView!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var whiteCircle: UIImageView!
    

    let gameData = GameData()
    let userDefault = UserDefaults.standard
    var sliderDefault: Float!
    
    @IBAction func retrieveGameSpeed(_ sender: Any) {
        let speed = String(format: "%.2f", gameSpeedSlider.value)
        gameSpeedLabel.text = ("(" + speed + " s /round)")
        userDefault.set(Float(speed), forKey: "speed")

    }
    
    /* Goes into photo library, lets you choose image and then sets the default to whatever was chosen */
    @IBAction func changeImagePressed(_ sender:
        Any) {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated:true, completion: nil)
        userDefault.set(profileImage.image?.pngData(), forKey: "profileImage")
    }
    
    /* UISwitch - Lets you see if User decides to change background color
     * If true -> Sets global default to true
     * If false -> Sets global default to false
     */
    @IBAction func isSwitchToggled(_ sender: UISwitch) {
        if sender.isOn {
            userDefault.set(true, forKey: "switch")
            bgSwitch.setOn(true, animated:true)
            let paleRed = UIColor(rgb: 0xff8080)
            userDefault.set(paleRed, forKey: "bgColor")
            whiteCircle.isHidden = true
            bgCircle.isHidden = false
        } else {
            userDefault.set(false, forKey: "switch")
            bgSwitch.setOn(false, animated:true)
            userDefault.set(UIColor.white, forKey: "bgColor")
            whiteCircle.isHidden = false
            bgCircle.isHidden = true
        }
    }
    
    /* Controls background color, checks to see if the UISwitch is toggled
     * If UISwitch == True -> Switches background colors to selected color
     * If UISwitch == False -> Stays white
     */
    
    @IBAction func changeBackground(_ sender: Any) {
        
        if userDefault.bool(forKey: "switch") {
            switch backgroundColorButtons.selectedSegmentIndex {
            // Red switch
            case 0:
                let paleRed = UIColor(rgb: 0xff8080)
                userDefault.set(paleRed, forKey: "bgColor")
                self.bgCircle?.tintColor = paleRed
            // Blue switch
            case 1:
                let paleBlue = UIColor(rgb: 0xccffff)
                userDefault.set(paleBlue, forKey: "bgColor")
                print("swapping to blue")
                self.bgCircle?.tintColor = paleBlue
            
            // Green switch
            case 2:
                let paleGreen = UIColor(rgb: 0xcdffc5)
                userDefault.set(paleGreen, forKey: "bgColor")
                print("swapping to green")
                bgCircle?.tintColor = paleGreen
                
            // Yellow switch
            case 3:
                let paleYellow = UIColor(rgb: 0xffffcc)
                userDefault.set(paleYellow, forKey: "bgColor")
                print("swapping to yellow")
                bgCircle?.tintColor = paleYellow
            default:
                break
            }
        } else {
            userDefault.set(UIColor.white, forKey: "bgColor")

        }
        
    }
    
    @IBAction func updateNameField(_ sender: Any) {
        
        if nameField.isFirstResponder == true {
            nameField.placeholder = nil
        }

    }
 
    @IBAction func clearAgeField(_ sender: Any) {
        ageField.placeholder = nil
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
 
    /* Updates age from the ageFieldTextField into the ageLabel
     * User gets an alert for if they would like to update, they can confirm or cancel
     */
    @IBAction func updatePressed(_ sender: Any) {
        
        ageField.resignFirstResponder()
        guard let age = Int(ageField.text!) else {
            print("Not updating age")
            return
        }

        /* User to confirm update */
        let confirmUpdate = UIAlertController(title: "Update Age", message: "Are you sure you want to update the player age to \(age)", preferredStyle: .alert)

       confirmUpdate.addAction(UIAlertAction(title: "Update", style: .cancel, handler: { (handler) in (
        self.userDefault.set(Int(age), forKey: "age"),
            self.ageLabel.text = ("age: " + "\(age)")
       )}))
        
        confirmUpdate.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))

        self.present(confirmUpdate, animated: true)

    }

    /* Go back to main view and save name + image */
    @IBAction func donePressed(_ sender: UIBarButtonItem) {
        userDefault.set(nameField.text, forKey: "name")
      // userDefault.set(profileImage, forKey:"profileImage")
        _ = navigationController?.popToRootViewController(animated: true)
        userDefault.set(profileImage.image?.pngData(), forKey: "profileImage")
    }
    
    /* Loading settings page */
    override func viewDidLoad() {
        super.viewDidLoad()
        updateAgeBtn.layer.cornerRadius = 5
        updateAgeBtn.clipsToBounds = true
        // Do any additional setup after loading the view.
        bgSwitch.addTarget(self, action: #selector(isSwitchToggled), for: .valueChanged)
        
        // For text field
        self.nameField.delegate = self
        self.ageField.delegate = self
        
        let nameString = NSAttributedString.init(string: "Your Name Here", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black])

        let updateAgeString = NSAttributedString.init(string: "Update age here", attributes: [NSAttributedString.Key.foregroundColor : UIColor.darkGray])
        nameField.attributedPlaceholder = nameString
        ageField.attributedPlaceholder = updateAgeString
        
        // Image picker
        imagePicker.delegate = self
        
        // Setup defaults
        sliderDefault = userDefault.float(forKey: "speed")
        self.ageLabel.text = ("age: " + "\(userDefault.integer(forKey: "age"))")
        self.gameSpeedSlider.value = sliderDefault
        self.gameSpeedLabel.text = ("(" + "\(sliderDefault!)" + " s /round)")
        self.bgSwitch.setOn(userDefault.bool(forKey: "switch"), animated:true)
        self.nameField.text = (userDefault.string(forKey: "name"))
        self.profileImage.image = UIImage(data: (UserDefaults.standard.object(forKey: "profileImage") as! Data))
        
        /* Decide which bg color to display */
        if userDefault.bool(forKey: "switch") {
            bgCircle.isHidden = false
            whiteCircle.isHidden = true
        } else {
            bgCircle.isHidden = true
            whiteCircle.isHidden = false
        }
    }
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

// - Cite https://stackoverflow.com/questions/24263007/how-to-use-hex-color-values
extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}
