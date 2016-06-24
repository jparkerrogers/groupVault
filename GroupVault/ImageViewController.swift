//
//  ImageViewController.swift
//  GroupVault
//
//  Created by Jonathan Rogers on 6/24/16.
//  Copyright © 2016 Jonathan Rogers. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
