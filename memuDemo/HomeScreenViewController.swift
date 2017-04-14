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
import EasyToast

class HomeScreenViewController: UIViewController {

    @IBOutlet weak var btnMenuButton: UIBarButtonItem!
    @IBOutlet weak var searchField: UITextField!
    var url = "http://csci571-hw8-163622.appspot.com/?keyword="
    
    @IBAction func clear(_ sender: Any) {
        searchField.text = ""
    }
    @IBAction func moveToTabBar(_ sender: Any) {
        
        if searchField.text != ""{
            searchFieldGL = searchField.text!
            
            // change the current view to the next view
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let resultViewController = storyBoard.instantiateViewController(withIdentifier: "SWRevealViewController2")
            self.present(resultViewController, animated:false, completion:nil)
        }
        else{
            self.view.showToast("Enter a valid query!", position: .bottom, popTime: 5, dismissOnTap: false)
        }
        
        
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

