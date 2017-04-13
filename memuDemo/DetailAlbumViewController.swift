//
//  DetailAlbumViewController.swift
//  memuDemo
//
//  Created by kaien on 4/10/17.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftSpinner

let cellID = "cell"

class DetailAlbumViewController: UIViewController,UITableViewDelegate,UITableViewDataSource  {
    var selectedIndexPath : IndexPath?

    @IBOutlet weak var tblTableView: UITableView!
    
    var detailAlbumIdArray = [String]()
    var detailPhotoTitleNameArray = [String]()
    var detailAlbumUrlArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //test.text = detailIdGL
        detailAlbumIdArray = [String]()
        detailPhotoTitleNameArray = [String]()
        detailAlbumUrlArray = [String]()
        tblTableView.register(UITableViewCell.self, forCellReuseIdentifier: "DetailAlbumCell")
        
        let tmpId = "134972803193847"
        //let detailUrl = url + "id=\(detailIdGL)"
        let detailUrl = url + "id=\(tmpId)"
        print(detailUrl)
        
        SwiftSpinner.show("Loading Data...")
        Alamofire.request(detailUrl)
            .responseJSON{ response in
                if let json = response.result.value {
                    
                    let swiftyJsonVar = JSON(json)
                    for (_, subJson): (String, JSON) in swiftyJsonVar["albums"]["data"]{
                        //detailPhotoTitleNameArray.append(String(subJson["name"].description as!)!);)
                        self.detailPhotoTitleNameArray.append(subJson["name"].description)
                        for (_, subJson2): (String, JSON) in subJson["photos"]["data"]{
                            self.detailAlbumUrlArray.append(subJson2["picture"].description)
                            self.detailAlbumIdArray.append(subJson2["id"].description)
                            //print(subJson2["id"]) // for original picture
                        }
                        
                        //print(subJson["name"]) // photo title
                    }
                    print(self.detailPhotoTitleNameArray)
                    print(self.detailAlbumUrlArray)
                    print(self.detailAlbumIdArray)

                }
                self.tblTableView.reloadData()
                SwiftSpinner.hide()
        }
        
        
        
        
        
        
        
        
        
        
        
        
        

        
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
        return detailPhotoTitleNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(3)
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as! DetailAlbumCell
        cell.title.text = detailPhotoTitleNameArray[indexPath.row]
        cell.photo1.downloadedFrom(link: detailAlbumUrlArray[indexPath.row*2])
        cell.photo2.downloadedFrom(link: detailAlbumUrlArray[indexPath.row*2+1])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(4)
        let previousIndexPath = selectedIndexPath
        if indexPath == selectedIndexPath {
            selectedIndexPath = nil
        }
        else{
            selectedIndexPath = indexPath
        }
        
        var indexPaths : Array<IndexPath> = []
        if let previous = previousIndexPath {
            indexPaths += [previous]
        }
        if let current = previousIndexPath {
            indexPaths += [current]
        }
        if indexPath.count > 0 {
            tableView.reloadRows(at: indexPaths, with: UITableViewRowAnimation.automatic)
        }
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (cell as! DetailAlbumCell).watchFrameChanges()
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (cell as! DetailAlbumCell).ignoreFrameChanges()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath == selectedIndexPath {
            return DetailAlbumCell.expandedHeight
        }
        else{
            return DetailAlbumCell.defaultHeight
        }
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
