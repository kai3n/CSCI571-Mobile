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
import EasyToast
import Social
import FacebookShare
import FacebookLogin
import FacebookCore



class DetailAlbumViewController: UIViewController,UITableViewDelegate,UITableViewDataSource  {
    var selectedIndexPath : IndexPath?

    @IBOutlet weak var tblTableView: UITableView!
    
    @IBAction func pressedBackbtn(_ sender: Any) {
        fromDetail = true
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "SWRevealViewController2")
        self.present(resultViewController, animated:false, completion:nil)   
    }
    var detailAlbumIdArray = [String]()
    var detailPhotoTitleNameArray = [String]()
    var detailAlbumUrlArray = [String]()
    var favorite = false
    
    @IBAction func showActionSheet(_ sender: Any) {
        let dict:[String:String] = ["id":currentDetailIdGL,"name":currentUserNameGL,"url":currentUserProfileUrlGL]
        
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //test.text = detailIdGL
        detailAlbumIdArray = [String]()
        detailPhotoTitleNameArray = [String]()
        detailAlbumUrlArray = [String]()
        tblTableView.register(UITableViewCell.self, forCellReuseIdentifier: "DetailAlbumCell")
        
        
        


        

        
//        let optionBarButtonItem = UIBarButtonItem(image: UIImage(named:"options"), style: UIBarButtonItemStyle.plain, target:self, action: #selector(UserViewController.add))
//        self.navigationItem.setRightBarButton(optionBarButtonItem, animated: true)
        //self.navigationController?.navigationBar.backItem?.title = "zz"
//        weak var weakSelf = self
//        navigationItem.leftBarButtonItems = CustomBackButton.createWithText(text: "a", color: UIColor.blue, target: weakSelf, action: #selector(DetailAlbumViewController.tappedBackButton))

//        let optionBarButtonItem = UIBarButtonItem(image: UIImage(named:"options"), style: UIBarButtonItemStyle.plain, target:self, action: #selector(DetailAlbumViewController.add))
//        self.navigationItem.rightBarButtonItem = optionBarButtonItem
        //self.navigationItem.hidesBackButton = true
//        let backButton = UIBarButtonItem(image: UIImage(named:"back"),style: UIBarButtonItemStyle.plain, target:self, action: #selector(DetailAlbumViewController.back))
//        self.navigationItem.leftBarButtonItem = backButton
//        self.automaticallyAdjustsScrollViewInsets = true
        
        let tmpId = "134972803193847"
        //let detailUrl = url + "id=\(detailIdGL)"
        let detailUrl = url + "id=\(currentDetailIdGL)"
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
