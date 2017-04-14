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
    
    @IBOutlet weak var tblTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        detailProfileUrl = "" // todo: store id
        detailContentArray = [String]()
        detailTimeArray = [String]()
        
        
        
        let tmpId = "134972803193847"
        //let detailUrl = url + "id=\(detailIdGL)"
        let detailUrl = url + "id=\(tmpId)"
        print(detailUrl)
        
        SwiftSpinner.show("Loading Data...")
        Alamofire.request(detailUrl)
            .responseJSON{ response in
                if let json = response.result.value {
                    
                    let swiftyJsonVar = JSON(json)
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
        cell.content.text = self.detailContentArray[indexPath.row]
        cell.postTime.text = self.detailTimeArray[indexPath.row]
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
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
