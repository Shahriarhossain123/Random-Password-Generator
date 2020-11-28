//
//  ProfileVC.swift
//  Random Password Generator
//
//  Created by Shishir_Mac on 11/25/20.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet weak var navProfile: UINavigationItem!
    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var labelGeneral: UILabel!
    @IBOutlet weak var labelAccount: UILabel!
    @IBOutlet weak var labelSync: UILabel!
    @IBOutlet weak var labelPromated: UILabel!
    @IBOutlet weak var labelOther: UILabel!
    @IBOutlet weak var labelPro: UILabel!
    @IBOutlet weak var labelHelp: UILabel!
    @IBOutlet weak var labelAbout: UILabel!
    @IBOutlet weak var viewAccount: UIView!
    @IBOutlet weak var viewSync: UIView!
    @IBOutlet weak var viewPromated: UIView!
    @IBOutlet weak var viewHelp: UIView!
    @IBOutlet weak var viewAbout: UIView!
    @IBOutlet weak var buttonLog: UIButton!
    
    var isLogIn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ProfileViewDesign()
        // Do any additional setup after loading the view.
    }
    
    
    func ProfileViewDesign() {
        
        if isLogIn {
            buttonLog.titleLabel?.text = "Log In"
        } else{
            buttonLog.titleLabel?.text = "Log Out"
        }
        
        labelName.text = "User Name"
        labelEmail.text = "User Email"
        labelGeneral.text = "GENERAL"
        labelPro.text = "Upgrade to Pro \u{1F4A0}"
        labelSync.text = "Sync"
        labelHelp.text = "Help Center"
        labelOther.text = "OTHER"
        labelAbout.text = "About Us"
        labelPromated.text = "PROMATED"
        labelAccount.text = "Account Settings"
        
        imageProfile.layer.cornerRadius = imageProfile.frame.size.width / 2
        buttonLog.layer.cornerRadius = 5
        
        viewAbout.layer.cornerRadius = 5
        viewAccount.layer.cornerRadius = 5
        viewSync.layer.cornerRadius = 5
        viewHelp.layer.cornerRadius = 5
        viewPromated.layer.cornerRadius = 5
    }
    
    @IBAction func buttonProfileAction(_ sender: UIButton) {
    }
    
    
    @IBAction func buttonLogAction(_ sender: UIButton) {
//        if isLogIn {
//            buttonLog.titleLabel?.text = "Log In"
//        } else{
//            buttonLog.titleLabel?.text = "Log Out"
//        }
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
