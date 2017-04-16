//
//  menuViewController.swift
//  memuDemo
//
//  Created by Parth Changela on 09/10/16.
//  Copyright © 2016 Parth Changela. All rights reserved.
//

import UIKit

class menuViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tblTableView: UITableView!
    
    var appNameArray:Array = [String]()
    var appIconArray:Array = [UIImage]()
    var manuNameArray:Array = [String]()
    var manuIconArray:Array = [UIImage]()
    var myNameArray:Array = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appNameArray = ["FB Search"]
        appIconArray = [UIImage(named:"fb")!]
        manuNameArray = ["Home","Favorites"]
        manuIconArray = [UIImage(named:"home")!,UIImage(named:"favorite")!]
        myNameArray = ["About me"]
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return appNameArray.count
        }
        if section == 1 {
            return manuNameArray.count
        }
        else {
            return myNameArray.count
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
        if indexPath.section == 0 {
            cell.lblMenuname.text! = appNameArray[indexPath.row]
            cell.imgIcon.image = appIconArray[indexPath.row]
        }
        if indexPath.section == 1 {
            
            cell.lblMenuname.text! = manuNameArray[indexPath.row]
            cell.imgIcon.image = manuIconArray[indexPath.row]
        }
        if indexPath.section == 2 {
            cell.lblMenuname.text! = myNameArray[indexPath.row]
            //cell.imgIcon.image = appIconArray[indexPath.row]
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let revealviewcontroller = self.revealViewController()
        
        let cell:MenuCell = tableView.cellForRow(at: indexPath) as! MenuCell
        print(cell.lblMenuname.text!)
        if cell.lblMenuname.text! == "Home"
        {
            print("Home Tapped")
            
            let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "HomeScreenViewController") as! HomeScreenViewController
            let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)
            
            revealviewcontroller?.pushFrontViewController(newFrontController, animated: true)
            
        }
        if cell.lblMenuname.text! == "Favorites"
        {
            print("favorites Tapped")
            isFavoriteTab = true
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let resultViewController = storyBoard.instantiateViewController(withIdentifier: "SWRevealViewController2")
            self.present(resultViewController, animated:false, completion:nil)
        }
        if cell.lblMenuname.text! == "About me"
        {
            let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "aboutMeViewController") as! aboutMeViewController
            let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)
            
            revealviewcontroller?.pushFrontViewController(newFrontController, animated: true)
        }
        if cell.lblMenuname.text! == "Setting"
        {
           print("setting Tapped")
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 1 {
            return "MENU"
        }
        else if section == 2 {
            return "OTHERS"
        }
        else {
            return ""
        }
    }
    
    
    
    /*
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! userCell
     
     
     if indexPath.section == 0 {
     cell.label.text = data[indexPath.row]
     }
     else {
     cell.label.text = data1[indexPath.row]
     }
     return cell
     
     
     }
     
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
     if section == 0 {
     return data.count
     }
     return data1.count
     
     }
     
     func numberOfSections(in tableView: UITableView) -> Int {
     return 2
     }
     
     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
     if section == 0 {
     return "Data 0"
     }
     return "Data 1"
     }
     
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     print("selected \(indexPath.section) section \(indexPath.row) row")
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

}
