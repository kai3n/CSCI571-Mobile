//
//  DetailPostViewController.swift
//  memuDemo
//
//  Created by kaien on 4/10/17.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftSpinner

class DetailPostViewController: UIViewController,UITableViewDelegate,UITableViewDataSource  {

    var detailProfileUrl:String = ""
    var detailContentArray = [String]()
    var detailTimeArray = [String]()
    var favorite = false
    
    @IBAction func pressedBackbtn(_ sender: Any) {
        fromDetail = true
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "SWRevealViewController2")
        self.present(resultViewController, animated:false, completion:nil)
    }
    
    @IBAction func showActionSheet(_ sender: Any) {
        let dict:[String:String] = ["id":currentDetailIdGL,"name":currentUserNameGL,"type":currentType, "url":currentUserProfileUrlGL]
        
        if ((defaults.object(forKey: currentDetailIdGL) as? [String:String]) != nil){
            favorite = true
        }
        else{
            favorite = false
        }
        
        
        let actionSheet = UIAlertController(title: "Image Source", message: "Choose camera or your photo library", preferredStyle: .actionSheet)
        
        if favorite{
            let removeFavorite = UIAlertAction(title:"Remove to favorites", style: .default) { (action) in
                self.view.showToast("remove Favorite", position: .bottom, popTime: 3, dismissOnTap: false)
                defaults.removeObject(forKey: currentDetailIdGL)
                defaults.synchronize()
                print("false")
                self.favorite = false
            }
            actionSheet.addAction(removeFavorite)
        }
        else{
            let addFavorite = UIAlertAction(title:"Add to favorites", style: .default) { (action) in
                self.view.showToast("add Favorite", position: .bottom, popTime: 3, dismissOnTap: false)
                defaults.set(dict, forKey:currentDetailIdGL)
                defaults.synchronize()
                print("true")
                self.favorite = true
            }
            actionSheet.addAction(addFavorite)
        }
        
        
        let share = UIAlertAction(title:"Share", style: .default) { (action) in
            
            print("share")
            //
            
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            print("cancel")
        }
        
        actionSheet.addAction(share)
        actionSheet.addAction(cancel)
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    @IBOutlet weak var tblTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        detailProfileUrl = "" // todo: store id
        detailContentArray = [String]()
        detailTimeArray = [String]()
        tblTableView.estimatedRowHeight = 100
        tblTableView.rowHeight = UITableViewAutomaticDimension
        
        
        
        let detailUrl = url + "id=\(currentDetailIdGL)"
        print(detailUrl)
        
        SwiftSpinner.show("Loading Data...")
        Alamofire.request(detailUrl)
            .responseJSON{ response in
                if let json = response.result.value {
                    
                    let swiftyJsonVar = JSON(json)
                    if swiftyJsonVar["posts"].count > 0{
                        let data = swiftyJsonVar["picture"]["data"]
                        for (i, j): (String, JSON) in data{
                            if i == "url"{
                                self.detailProfileUrl = j.description
                            }
                        }
                        for (_, subJson): (String, JSON) in swiftyJsonVar["posts"]["data"]{
                            //detailPhotoTitleNameArray.append(String(subJson["name"].description as!)!);)
                            print(subJson["message"].description)
                            print(subJson["created_time"].description)
                            self.detailContentArray.append(subJson["message"].description)
                            
                            
                            let time = subJson["created_time"].description
                            let time2 = time.replacingOccurrences(of: "T", with: " ")
                            let time3 = time2.replacingOccurrences(of: "+", with: " ")
                            let dateFormatter = DateFormatter()
                            print(time3)
                            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss SSS"
                            let fullDate = dateFormatter.date(from: time3)
                            dateFormatter.dateFormat = "dd MMM yyyy HH:mm:ss"
                            let time4 = dateFormatter.string(from: fullDate!)
                            print(time4)
                            self.detailTimeArray.append(time4)
                        }
                        print(self.detailContentArray)
                        print(self.detailTimeArray)
                        
                    }
                    else{
                        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
                        label.center = CGPoint(x: 190, y: 285)
                        label.textAlignment = .center
                        label.text = "No contents"
                        self.view.addSubview(label)
                        self.tblTableView.isHidden = true
                    }
                    
                    
                }
                self.tblTableView.reloadData()
                SwiftSpinner.hide()
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        print(1)
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(2)
        return detailContentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(3)
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! DetailPostCell
        cell.profilePicture.downloadedFrom(link: self.detailProfileUrl)
        cell.postContent.text = self.detailContentArray[indexPath.row]
        cell.postContent.numberOfLines = 20
        cell.postTime.text = self.detailTimeArray[indexPath.row]
        cell.updateConstraintsIfNeeded()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(4)
//        let previousIndexPath = selectedIndexPath
//        if indexPath == selectedIndexPath {
//            selectedIndexPath = nil
//        }
//        else{
//            selectedIndexPath = indexPath
//        }
//        
//        var indexPaths : Array<IndexPath> = []
//        if let previous = previousIndexPath {
//            indexPaths += [previous]
//        }
//        if let current = previousIndexPath {
//            indexPaths += [current]
//        }
//        if indexPath.count > 0 {
//            tableView.reloadRows(at: indexPaths, with: UITableViewRowAnimation.automatic)
//        }
    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableViewAutomaticDimension
//    }
//
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableViewAutomaticDimension
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
