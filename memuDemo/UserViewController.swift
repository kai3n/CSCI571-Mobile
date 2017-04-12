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

class UserViewController: UIViewController {

    @IBOutlet weak var btnMenuButton: UIBarButtonItem!
    var url = "http://csci571-hw8-163622.appspot.com/?keyword="
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        url += searchFieldGL + "&type=user"
        print(url)
        
        SwiftSpinner.show("Loading Data...")
        //sidebarMenuOpen = false
        Alamofire.request(url)
            .responseJSON{ response in debugPrint(response)
                if let json = response.result.value {
                    print("JSON: \(json)")
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
