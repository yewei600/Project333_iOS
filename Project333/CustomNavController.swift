//
//  CustomNavController.swift
//  Project333
//
//  Created by Eric Wei on 2017-04-06.
//  Copyright © 2017 EricWei. All rights reserved.
//

import Foundation
import UIKit

class CustomNavController: UINavigationController {
    
    var newOutfitRequest: Bool!
    
    override func viewDidLoad() {
        let controller = navigationController?.childViewControllers[0] as! PickOutfitViewController
        
        controller.newOutfitRequest = newOutfitRequest
    }
    
}
