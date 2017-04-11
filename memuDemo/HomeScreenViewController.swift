//
//  ViewController.swift
//  memuDemo
//
//  Created by Parth Changela on 09/10/16.
//  Copyright © 2016 Parth Changela. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController {

    @IBOutlet weak var btnMenuButton: UIBarButtonItem!
    @IBAction func moveToTabBar(_ sender: Any) {
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
            btnMenuButton.action = "revealToggle:"
            
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

