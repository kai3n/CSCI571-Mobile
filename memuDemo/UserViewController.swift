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
        
        if nextUrlAvailable {
            self.userIdArray = [String]()
            self.userNameArray = [String]()
            self.userUrlArray = [String]()
            self.userIconArray = [UIImage]()
            self.starIconArray = [UIImage]()
            
            self.offSet += 10
            let searchUrl = url + "keyword=" + searchFieldGL + "&type=user&offset=" + "\(offSet)"
            currentUrlGL = searchUrl
            print(searchUrl)
            print("p1")
            SwiftSpinner.show("Loading Data...")
            Alamofire.request(searchUrl)
                .responseJSON{ response in
                    if let json = response.result.value {
                        let swiftyJsonVar = JSON(json)
                        print("p2")
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
                    print(self.userNameArray)
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
            let searchUrl = url + "keyword=" + searchFieldGL + "&type=user&offset=" + "\(offSet)"
            currentUrlGL = searchUrl
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
    
//    func back(){
//        self.tabBarController?.tabBar.isHidden = false
//    }
//    func tappedBackButton() {
//        print(1)
//        // Do your thing
//        
//        self.navigationController!.popViewController(animated: true)
//    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = false
//        self.navigationItem.hidesBackButton = true
//        let backButton = UIBarButtonItem(image: UIImage(named:"options"),style: UIBarButtonItemStyle.plain, target:self, action: #selector(UserViewController.back))
//        self.navigationItem.leftBarButtonItem = backButton
//        self.automaticallyAdjustsScrollViewInsets = true
        
        
        let searchUrl = url + "keyword=" + searchFieldGL + "&type=user&offset=" + "\(offSet)"
        print(searchUrl)
        currentUrlGL = searchUrl
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
//        let userViewController = self.storyboard?.instantiateViewController(withIdentifier: "UserViewController") as! UserViewController
//        self.navigationController?.pushViewController(userViewController, animated: true)
//        
        //self.navigationController?.navigationBar.isHidden = true
//        let optionBarButtonItem = UIBarButtonItem(image: UIImage(named:"options"), style: UIBarButtonItemStyle.plain, target:self, action: #selector(UserViewController.add))
        //self.navigationItem.backBarButtonItem?.title = "Results!"
        
//        self.navigationItem.setRightBarButton(optionBarButtonItem, animated: true)
        //self.navigationItem.rightBarButtonItem = optionBarButtonItem
        
        detailIdGL = userIdArray[indexPath.row]
        
        
    }
    func add(){
        print("add")
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
