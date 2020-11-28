//
//  BookmarkVC.swift
//  Random Password Generator
//
//  Created by Shishir_Mac on 11/16/20.
//

import UIKit
import CoreData

class BookmarkVC: UIViewController, UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var navigationBookmark: UINavigationItem!
    @IBOutlet weak var barButtonSearch: UIBarButtonItem!
    @IBOutlet weak var tableBookmark: UITableView!
    
    var passwords: [NSManagedObject] = []
    var startText = "*"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableBookmark.register(UINib(nibName: "BookmarkVCell", bundle: nil), forCellReuseIdentifier: "BookmarkVCell")
        tableBookmark.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableBookmark.reloadData()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "DataSave")
        
        do {
            passwords = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        tableBookmark.reloadData()
    }
    
    
    @IBAction func barButtonSearchAction(_ sender: UIBarButtonItem) {
        print("Search")
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 18))
        let label = UILabel(frame: CGRect(x: 10, y: 5, width: tableView.frame.size.width, height: 18))
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "BOOKMARK"
        label.textColor = UIColor.lightGray
        view.addSubview(label)
        view.backgroundColor = .clear // Set your background color
        
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return passwords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:BookmarkVCell = tableBookmark.dequeueReusableCell(withIdentifier: "BookmarkVCell", for: indexPath) as! BookmarkVCell
        let password = passwords[indexPath.row]
        let passwordCount = (password.value(forKeyPath: "labelTagPassword") as? String)?.count
        cell.labelTagName.text = password.value(forKeyPath: "labelName") as? String
        cell.labelTagPassword.text = "**********"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
//
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            //objects.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
//        }
//
//    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
