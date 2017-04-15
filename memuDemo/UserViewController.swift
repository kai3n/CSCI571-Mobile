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

    var userIdArray = [String]()
    var userNameArray = [String]()
    var userUrlArray = [String]()
    var userIconArray = [UIImage]()
    var starIconArray = [UIImage]()
    var currentRow:Int!
    var nextUrlAvailable = Bool()
    var previousUrlAvailable = Bool()
    var offSet = 0
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnMenuButton: UIBarButtonItem!

    @IBAction func next(_ sender: Any) {
        if fromDetail{
            self.tabBarController?.selectedIndex = tabBarIndexGL
        }
        else{
            self.tabBarController?.selectedIndex = 0
        }
        if nextUrlAvailable {
            self.userIdArray = [String]()
            self.userNameArray = [String]()
            self.userUrlArray = [String]()
            self.userIconArray = [UIImage]()
            self.starIconArray = [UIImage]()
            self.offSet += 10
            fromHome = false
            fromDetail = false
            let searchUrl = url + "keyword=" + searchFieldGL + "&type=user&offset=" + "\(offSet)"
            currentUrlGL[0] = searchUrl
            
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
                                for data in item["picture"] as! [String:AnyObject]{
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
        if revealViewController() != nil {
            btnMenuButton.target = revealViewController()
            btnMenuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        }
    }
    @IBAction func previous(_ sender: Any) {
        
        if previousUrlAvailable {
            self.userIdArray = [String]()
            self.userNameArray = [String]()
            self.userUrlArray = [String]()
            self.userIconArray = [UIImage]()
            self.starIconArray = [UIImage]()
            self.offSet -= 10
            fromHome = false
            fromDetail = false
            if self.offSet < 0{
                self.offSet = 0
            }
            
            let searchUrl = url + "keyword=" + searchFieldGL + "&type=user&offset=" + "\(offSet)"
            currentUrlGL[0] = searchUrl

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
                                for data in item["picture"] as! [String:AnyObject]{
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
        if revealViewController() != nil {
            btnMenuButton.target = revealViewController()
            btnMenuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("user view!")
        self.tabBarController?.tabBar.isHidden = false
        if fromDetail{
            self.tabBarController?.selectedIndex = tabBarIndexGL
        }
        else{
            self.tabBarController?.selectedIndex = 0
        }
        fromDetail = false
        var searchUrl = url + "keyword=" + searchFieldGL + "&type=user&offset=" + "\(offSet)"
        if fromHome{
            currentUrlGL[0] = searchUrl
        }
        else{
            searchUrl = currentUrlGL[0]
        }
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
                            for data in item["picture"] as! [String:AnyObject]{
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
        if revealViewController() != nil {
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
        
        if ((defaults.object(forKey: userIdArray[indexPath.row]) as? [String:String]) != nil){
            cell.starImage.image = UIImage(named: "filled")
        }
        else{
            cell.starImage.image = UIImage(named: "empty")
        }
            return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(userNameArray)
        return userNameArray.count
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tabBarController?.tabBar.isHidden = true
        currentDetailIdGL = userIdArray[indexPath.row]
        currentUserNameGL = userNameArray[indexPath.row]
        currentUserProfileUrlGL = userUrlArray[indexPath.row]
        tabBarIndexGL = 0
    }
}
