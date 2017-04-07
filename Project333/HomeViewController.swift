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
        if let todaysOutfit = try? UserDefaults.standard.array(forKey: "todaysOutfit") as? [URL] {
            print("todaysOutfit array has \(todaysOutfit?.count) elements!!!")
        }
        
        performSegue(withIdentifier: "FromNewOutFitSegue", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FromNewOutFitSegue" {
            let controller = segue.destination as! CustomNavController
            controller.fromNewOutfitButton = true
            print("set CustomNavController fromNewOutfitButton == \(true)")
        }
    }
}
