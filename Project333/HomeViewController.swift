//
//  HomeViewController.swift
//  Project333
//
//  Created by Eric Wei on 2017-04-01.
//  Copyright © 2017 EricWei. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var startChallengeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func newOutfitButtonClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "", sender: self)
    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let controller = segue.destination as! PickOutfitViewController
//        
//        controller.newOutfitRequest = true
//    }
    
}
