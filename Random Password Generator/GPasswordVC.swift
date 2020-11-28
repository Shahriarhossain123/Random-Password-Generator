//
//  GPasswordVC.swift
//  Random Password Generator
//
//  Created by Shishir_Mac on 11/12/20.
//

import UIKit
import CoreData

class GPasswordVC: UIViewController {
    
    @IBOutlet weak var lableTitle: UILabel!
    @IBOutlet weak var lableGPtext: UILabel!
    @IBOutlet weak var lableLengthText: UILabel!
    @IBOutlet weak var lableSettings: UILabel!
    @IBOutlet weak var lableNumber: UILabel!
    @IBOutlet weak var lableLowercase: UILabel!
    @IBOutlet weak var lableUppercase: UILabel!
    @IBOutlet weak var lableSChar: UILabel!
    @IBOutlet weak var buttonProfile: UIButton!
    @IBOutlet weak var buttonCopy: UIButton!
    @IBOutlet weak var buttonSave: UIButton!
    @IBOutlet weak var buttonGeneratedPassword: UIButton!
    @IBOutlet weak var viewPassword: UIView!
    @IBOutlet weak var viewNumber: UIView!
    @IBOutlet weak var viewLowercase: UIView!
    @IBOutlet weak var viewUppercase: UIView!
    @IBOutlet weak var viewSChar: UIView!
    @IBOutlet weak var viewSlider: UIView!
    @IBOutlet weak var switchNumber: UISwitch!
    @IBOutlet weak var sliderNumber: UISlider!
    @IBOutlet weak var switchLowercase: UISwitch!
    @IBOutlet weak var switchUppercase: UISwitch!
    @IBOutlet weak var switchSChar: UISwitch!
    @IBOutlet weak var lableGetPassword: UILabel!
    
    var num:Int? = 0
    var passwords: [NSManagedObject] = []
    
    
    var upperChar = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    var numberChar = "0123456789"
    var lowerChar = "abcdefghijklmnopqrstuvwxyz"
    var spChar = "@£$&(){}[]"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GPViewDesign()
        num = Int(sliderNumber.value)
        // Do any additional setup after loading the view.
    }
    
    func GPViewDesign(){
        //String
        lableTitle.text = "Random Password Generator"
        lableNumber.text = "Include Number"
        lableLowercase.text = "Include Lowercase"
        lableUppercase.text = "Include Uppercase"
        lableSChar.text = "Include Special Characters"
        lableSettings.text = "SETTINGS"
        lableGPtext.text = "GENERATED PASSWORD"
        lableGetPassword.text = nil
        
        //View
        viewPassword.layer.cornerRadius = 5
        viewNumber.layer.cornerRadius = 5
        viewLowercase.layer.cornerRadius = 5
        viewUppercase.layer.cornerRadius = 5
        viewSChar.layer.cornerRadius = 5
        viewSlider.layer.cornerRadius = 5
        
        //button
        buttonProfile.clipsToBounds = true
        buttonProfile.layer.cornerRadius = buttonProfile.frame.size.width / 2
        buttonProfile.layer.borderWidth = 1
        buttonProfile.layer.borderColor = UIColor.white.cgColor
        buttonCopy.layer.cornerRadius = 5
        buttonSave.layer.cornerRadius = 5
        buttonGeneratedPassword.layer.cornerRadius = 5
    }
    
    func randomString(length: Int?) -> String {
        var letters = ""
        //All On
        if switchNumber.isOn && switchLowercase.isOn && switchUppercase.isOn && switchSChar.isOn {
            letters = numberChar + lowerChar + upperChar + spChar
            
        } // only Number off
        else if switchNumber.isOn == false && switchLowercase.isOn && switchUppercase.isOn && switchSChar.isOn{
            letters = lowerChar + upperChar + spChar
            
        } // only Lowercase off
        else if switchNumber.isOn && switchLowercase.isOn == false && switchUppercase.isOn && switchSChar.isOn{
            letters = numberChar + upperChar + spChar
        } // only Upper Off
        else if switchNumber.isOn && switchLowercase.isOn && switchUppercase.isOn == false && switchSChar.isOn{
            letters = numberChar + lowerChar + spChar
            
        } // only number on
        else if switchNumber.isOn && switchLowercase.isOn == false && switchUppercase.isOn == false && switchSChar.isOn == false{
            letters = "numberChar"
        }
        else if switchNumber.isOn == false && switchLowercase.isOn == false && switchUppercase.isOn == false && switchSChar.isOn {
            switchSChar.isEnabled = false
        }
        
        return String((0..<length!).map{ _ in
            letters.randomElement()!
            
        })
    }
    
    @IBAction func buttonGeneratorAction(_ sender: UIButton) {
        if switchNumber.isOn == false && switchLowercase.isOn == false && switchUppercase.isOn == false && switchSChar.isOn == false{
            lableGetPassword.text = "All switch are off!!"
            
        } else{
            lableGetPassword.text = randomString(length: num)
        }
    }
    
    
    @IBAction func numberSlider(_ sender: UISlider) {
        
        let value = sliderNumber.value
        num = Int(value)
        lableGetPassword.text = String(num!)
        
        if switchNumber.isOn == false && switchLowercase.isOn == false && switchUppercase.isOn == false && switchSChar.isOn == false{
            lableGetPassword.text = "All switch are off!!"
            sender.isEnabled = false
            
        } else{
            sender.isEnabled = true
            lableGetPassword.text = randomString(length: num!)
        }
    }
    
    @IBAction func buttonCopyAction(_ sender: UIButton) {
        let pasteboard = UIPasteboard.general
        pasteboard.string = lableGetPassword.text
    }
    
    @IBAction func buttonSaveAction(_ sender: UIButton) {
        let passwordString = lableGetPassword.text
        var textField: UITextField?
        
        // create alertController
        let alertController = UIAlertController(title: "Password", message: "Save the password. Give a tag name.", preferredStyle: .alert)
        alertController.addTextField { (pTextField) in
            pTextField.placeholder = "Tag Name"
            pTextField.clearButtonMode = .whileEditing
            pTextField.borderStyle = .none
            textField = pTextField
        }
        
        // create cancel button
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (pAction) in
            alertController.dismiss(animated: true, completion: nil)
        }))
        
        // create Ok button
        alertController.addAction(UIAlertAction(title: "Save", style: .default, handler: { [self] (pAction) in
            // when user taps OK, you get your value here
            let name = textField?.text
            save(tagName: name!, tagPassword: passwordString!)
            alertController.dismiss(animated: true, completion: nil)
        }))
        
        // show alert controller
        self.present(alertController, animated: true, completion: nil)
    }
    
    func save(tagName: String, tagPassword: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "DataSave", in: managedContext)!
        let password = NSManagedObject(entity: entity, insertInto: managedContext)
        password.setValue(tagName, forKeyPath: "labelName")
        password.setValue(tagPassword, forKeyPath: "labelTagPassword")
        
        do {
            try managedContext.save()
            passwords.append(password)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
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
