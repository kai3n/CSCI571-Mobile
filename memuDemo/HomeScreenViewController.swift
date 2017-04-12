//
//  ViewController.swift
//  memuDemo
//
//  Created by Parth Changela on 09/10/16.
//  Copyright © 2016 Parth Changela. All rights reserved.
//
import UIKit
import Alamofire
import SwiftyJSON
import SwiftSpinner


class HomeScreenViewController: UIViewController {

    @IBOutlet weak var btnMenuButton: UIBarButtonItem!
    @IBOutlet weak var searchField: UITextField!
    var url = "http://csci571-hw8-163622.appspot.com/?keyword="
    
    @IBAction func moveToTabBar(_ sender: Any) {
        print(globalData[1])
        searchFieldGL = searchField.text!
//        url += searchField.text! + "&type=user"
//        print(url)
//        
//        SwiftSpinner.show("Loading Data...")
//        //sidebarMenuOpen = false
//        Alamofire.request(url)
//            .responseJSON{ response in debugPrint(response)
//                if let json = response.result.value {
//                    print("JSON: \(json)")
//                SwiftSpinner.hide()
//            }
        
//            .responseJSON { (responseData) -> Void in
//                if((responseData.result.value) != nil) {
//                    let swiftyJsonVar = JSON(responseData.result.value!)
//                    if let resData = swiftyJsonVar["results"].arrayObject {
//                        self.buff = resData as! [[String:AnyObject]]
//                        for item in self.buff{
//                            let b = Bill()
//                            b.setBill(JsonData: item)
//                            self.billsSet.append(b)
//                        }
//                    }
//                    if self.billsSet.count > 0 {
//                        // #Sort By LastName
//                        self.billsSetSortedByIntroducedOn = self.billsSet.sorted{$0.introducedOn > $1.introducedOn}
//                        self.billsSet = self.billsSetSortedByIntroducedOn
//                        
//                        self.BillsTable.reloadData()
//                        SwiftSpinner.hide()
//                    }
//                }
//        }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        // change the current view to the next view
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "SWRevealViewController2")
        self.present(resultViewController, animated:false, completion:nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if revealViewController() != nil {
            //            revealViewController().rearViewRevealWidth = 62
            btnMenuButton.target = revealViewController()
            btnMenuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            
//            revealViewController().rightViewRevealWidth = 150
//            extraButton.target = revealViewController()
//            extraButton.action = "rightRevealToggle:"
            
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

