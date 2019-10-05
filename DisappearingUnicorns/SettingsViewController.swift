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
    

    let gameData = GameData()
    let userDefault = UserDefaults.standard
    var sliderDefault: Float!
    
    @IBAction func retrieveGameSpeed(_ sender: Any) {
        let speed = String(format: "%.2f", gameSpeedSlider.value)
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

        } else {
            userDefault.set(false, forKey: "switch")
            bgSwitch.setOn(false, animated:true)
            userDefault.set(UIColor.white, forKey: "bgColor")
        }
    }
    
    // getter for namefield
    func getName() -> String {
        //let nameText: String! = nameField.text!
        //print(nameText)
       // print(nameField.text)
        return "testing"
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
                userDefault.set(paleRed, forKey: "bgColor")
                self.bgCircle?.changePngColorTo(color: UIColor.black)                //circle.tintColor = paleRed
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

    }

    @IBAction func clearAgeField(_ sender: Any) {
        ageField.placeholder = nil;
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
    
    /* Updates age from the ageFieldTextField into the ageLabel
     * User gets an alert for if they would like to update, they can confirm or cancel
     */
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
        gameData.savePhoto(profileImage.image!)
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
        let nameString = NSAttributedString.init(string: "Name", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black])

        let updateAgeString = NSAttributedString.init(string: "Update age here", attributes: [NSAttributedString.Key.foregroundColor : UIColor.darkGray])
        nameField.attributedPlaceholder = nameString
        ageField.attributedPlaceholder = updateAgeString

        // Image picker
        imagePicker.delegate = self
        
        // Setup defaults
        sliderDefault = userDefault.float(forKey: "speed")
        let age = userDefault.integer(forKey: "age")
        self.ageLabel.text = ("age: " + "\(age)")
        self.gameSpeedSlider.value = sliderDefault
        self.gameSpeedLabel.text = ("(" + "\(sliderDefault!)" + " s /round)")
        self.bgSwitch.setOn(userDefault.bool(forKey: "switch"), animated:true)

        
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
        // Get the new view controller using xsegue.destination.
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

extension UIImageView{
    func changePngColorTo(color: UIColor){
        guard let image =  self.image else {return}
        self.image = image.withRenderingMode(.alwaysTemplate)
        self.tintColor = color
    }
}


