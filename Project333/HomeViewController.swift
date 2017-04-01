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
    
    @IBOutlet weak var todaysOutfitView: UIView!
    @IBOutlet weak var savedOutFitsView: UIView!
    @IBOutlet weak var scheduleView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let todaysOutfitRecognizer = UITapGestureRecognizer(target: self, action: #selector(todaysOutfitsTapped(tapRecognizer:)))
        
        let outfitsRecognizer = UITapGestureRecognizer(target: self, action: #selector(outfitsTapped(tapRecognizer:)))
        
        //        let scheduleRecognizer = UITapGestureRecognizer(target: self, action: #selector()
        
        self.view.addGestureRecognizer(todaysOutfitRecognizer)
        self.view.addGestureRecognizer(outfitsRecognizer)
    }
    
    func todaysOutfitsTapped(tapRecognizer: UITapGestureRecognizer) {
        let alert = UIAlertController(title: "tap recognizer", message: "clicked today's outfit", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func outfitsTapped(tapRecognizer: UITapGestureRecognizer) {
        let alert = UIAlertController(title: nil, message: "Outfits tapped", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
