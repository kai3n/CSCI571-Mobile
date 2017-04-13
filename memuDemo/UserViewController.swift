//
//  UserViewController.swift
//  memuDemo
//
//  Created by kaien on 4/10/17.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftSpinner

class UserViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBAction func next(_ sender: Any) {
        self.tabBarController?.tabBar.isHidden = false
        if nextUrlAvailable {
            self.userIdArray = [String]()
            self.userNameArray = [String]()
            self.userUrlArray = [String]()
            self.userIconArray = [UIImage]()
            self.starIconArray = [UIImage]()
            
            self.offSet += 10
            let searchUrl = url + searchFieldGL + "&type=user&offset=" + "\(offSet)"
            print(searchUrl)
            SwiftSpinner.show("Loading Data...")
            Alamofire.request(searchUrl)
                .responseJSON{ response in
                    if let json = response.result.value {
                        let swiftyJsonVar = JSON(json)
                        if let resData = swiftyJsonVar["data"].arrayObject {
                            let userData = resData as! [[String:AnyObject]]
                            for item in userData{
                                self.userIdArray.append(String(item["id"] as! String))
                                self.userNameArray.append(String(item["name"] as! String))
                                //print(self.userNameArray)
                                for data in item["picture"] as! [String:AnyObject]{
                                    //print(data.value["url"] as! String)
                                    self.userUrlArray.append(String(data.value["url"] as! String))
                                }
                            }
                        }
                        if String(describing: swiftyJsonVar["paging"]["next"]).characters.count > 0 {
                            self.nextUrlAvailable = true
                        }
                        else{
                            self.nextUrlAvailable = false
                        }
                        if String(describing: swiftyJsonVar["paging"]["previous"]).characters.count > 0 {
                            self.previousUrlAvailable = true
                        }
                        else{
                            self.previousUrlAvailable = false
                        }
                    }
                    self.tableView.reloadData()
                    SwiftSpinner.hide()
            }
        }
        
        
//         Do any additional setup after loading the view.
        if revealViewController() != nil {
            //            revealViewController().rearViewRevealWidth = 62
            btnMenuButton.target = revealViewController()
            btnMenuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        }
    }
    
    @IBAction func previous(_ sender: Any) {
        
        self.tabBarController?.tabBar.isHidden = false
        if previousUrlAvailable {
            self.userIdArray = [String]()
            self.userNameArray = [String]()
            self.userUrlArray = [String]()
            self.userIconArray = [UIImage]()
            self.starIconArray = [UIImage]()
            self.offSet -= 10
            
            if self.offSet < 0{
                self.offSet = 0
            }
            let searchUrl = url + searchFieldGL + "&type=user&offset=" + "\(offSet)"
            print(searchUrl)
            SwiftSpinner.show("Loading Data...")
            Alamofire.request(searchUrl)
                .responseJSON{ response in
                    if let json = response.result.value {
                        
                        let swiftyJsonVar = JSON(json)
                        if let resData = swiftyJsonVar["data"].arrayObject {
                            let userData = resData as! [[String:AnyObject]]
                            for item in userData{
                                self.userIdArray.append(String(item["id"] as! String))
                                self.userNameArray.append(String(item["name"] as! String))
                                //print(self.userNameArray)
                                for data in item["picture"] as! [String:AnyObject]{
                                    //print(data.value["url"] as! String)
                                    self.userUrlArray.append(String(data.value["url"] as! String))
                                }
                            }
                        }
                        if String(describing: swiftyJsonVar["paging"]["next"]).characters.count > 0 {
                            self.nextUrlAvailable = true
                        }
                        else{
                            self.nextUrlAvailable = false
                        }
                        if String(describing: swiftyJsonVar["paging"]["previous"]).characters.count > 0 {
                            self.previousUrlAvailable = true
                        }
                        else{
                            self.previousUrlAvailable = false
                        }
                    }
                    self.tableView.reloadData()
                    SwiftSpinner.hide()
            }
        }
        
        
        // Do any additional setup after loading the view.
        if revealViewController() != nil {
            //            revealViewController().rearViewRevealWidth = 62
            btnMenuButton.target = revealViewController()
            btnMenuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        }
    }
    
    
    
    @IBOutlet weak var btnMenuButton: UIBarButtonItem!
    var userIdArray = [String]()
    var userNameArray = [String]()
    var userUrlArray = [String]()
    var userIconArray = [UIImage]()
    var starIconArray = [UIImage]()
    var currentRow:Int!
    var nextUrlAvailable = Bool()
    var previousUrlAvailable = Bool()
    var offSet = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = false
        let searchUrl = url + "keyword=" + searchFieldGL + "&type=user&offset=" + "\(offSet)"
        print(searchUrl)
        SwiftSpinner.show("Loading Data...")
        Alamofire.request(searchUrl)
            .responseJSON{ response in
                if let json = response.result.value {
                    
                    let swiftyJsonVar = JSON(json)
                    if let resData = swiftyJsonVar["data"].arrayObject {
                        let userData = resData as! [[String:AnyObject]]
                        for item in userData{
                            self.userIdArray.append(String(item["id"] as! String))
                            self.userNameArray.append(String(item["name"] as! String))
                            //print(self.userNameArray)
                            for data in item["picture"] as! [String:AnyObject]{
                                //print(data.value["url"] as! String)
                                self.userUrlArray.append(String(data.value["url"] as! String))
                            }
                        }
                    }
                    if String(describing: swiftyJsonVar["paging"]["next"]).characters.count > 0 {
                        self.nextUrlAvailable = true
                    }
                    else{
                        self.nextUrlAvailable = false
                    }
                    if String(describing: swiftyJsonVar["paging"]["previous"]).characters.count > 0 {
                        self.previousUrlAvailable = true
                    }
                    else{
                        self.previousUrlAvailable = false
                    }
                    //self.nextUrl = String(describing: swiftyJsonVar["paging"]["next"])
                    //self.previousUrl = String(describing:swiftyJsonVar["paging"]["previous"])
                }
                self.tableView.reloadData()
                SwiftSpinner.hide()
        }
        
        // Do any additional setup after loading the view.
        if revealViewController() != nil {
            //            revealViewController().rearViewRevealWidth = 62
            btnMenuButton.target = revealViewController()
            btnMenuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! userCell
            cell.label.text = userNameArray[indexPath.row]
            cell.userImage.downloadedFrom(link: userUrlArray[indexPath.row])
            cell.starImage.image = UIImage(named: "empty")
            return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(userNameArray)
        return userNameArray.count
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("selected \(indexPath.section) section \(indexPath.row) row")
//        currentRow = indexPath.row
//        performSegue(withIdentifier: "DetailController", sender: indexPath.row)
        self.tabBarController?.tabBar.isHidden = true
        detailIdGL = userIdArray[indexPath.row]
        
    }
    
    
    
//    override func willMove(toParentViewController parent: UIViewController?) {
//        if parent == nil {
//            print("aaa")
//            self.tabBarController?.tabBar.isHidden = false
//        }
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let detail:DetailTabController = segue.destination as! DetailTabController
//        detail.text = userIdArray[currentRow]
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
