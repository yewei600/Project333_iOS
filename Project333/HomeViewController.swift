//
//  HomeViewController.swift
//  Project333
//
//  Created by Eric Wei on 2017-04-01.
//  Copyright © 2017 EricWei. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class HomeViewController: UIViewController {
    
    @IBOutlet weak var startChallengeLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    
    var coreDataStack: CoreDataStack!
    var todaysOutfit = [Item]()
    
    override func viewWillAppear(_ animated: Bool) {
        todaysOutfit.removeAll()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let delegate = UIApplication.shared.delegate as! AppDelegate
        coreDataStack = delegate.stack
        
        WeatherClient.sharedInstance().getWeatherResponse { (temperature, locationName, error) in
            DispatchQueue.main.async {
                self.weatherLabel.text = "\(locationName): \(temperature-273.15) C"
            }
        }
    }
    
    @IBAction func newOutfitButtonClicked(_ sender: Any) {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Outfit")
        fetchRequest.predicate = NSPredicate(format: "name== %@", "today")
        
        if let fetchResults = try? coreDataStack.context.fetch(fetchRequest) as! [Outfit] {
            print("number of Outfits in core data = \(fetchResults.count)")
            if fetchResults.count == 1{
                let outfit = fetchResults[0]
                if outfit.item1 != nil {
                    todaysOutfit.append(outfit.item1!)
                } else if outfit.item2 != nil {
                    todaysOutfit.append(outfit.item2!)
                } else if outfit.item3 != nil {
                    todaysOutfit.append(outfit.item3!)
                }else if outfit.item4 != nil {
                    todaysOutfit.append(outfit.item4!)
                }else if outfit.item5 != nil {
                    todaysOutfit.append(outfit.item5!)
                }else if outfit.item6 != nil {
                    todaysOutfit.append(outfit.item6!)
                }else if outfit.item7 != nil {
                    todaysOutfit.append(outfit.item7!)
                }else if outfit.item8 != nil {
                    todaysOutfit.append(outfit.item8!)
                }else if outfit.item9 != nil {
                    todaysOutfit.append(outfit.item9!)
                }else if outfit.item10 != nil {
                    todaysOutfit.append(outfit.item10!)
                }
                
                performSegue(withIdentifier: "GoTodayOutfitSegue", sender: self)
            }
        }
        performSegue(withIdentifier: "FromNewOutFitSegue", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let identifier = segue.identifier {
            switch identifier {
            case "FromNewOutFitSegue":
                let controller = segue.destination as! CustomNavController
                controller.fromNewOutfitButton = true
            case "GoTodayOutfitSegue":
                let controller = segue.destination as! SavedOutfitViewController
                print("\(todaysOutfit.count) todays outfits")
                controller.items = todaysOutfit
            default:
                print("")
            }
        }
        
        //        if segue.identifier == "FromNewOutFitSegue" {
        //            let controller = segue.destination as! CustomNavController
        //            controller.fromNewOutfitButton = true
        //            print("set CustomNavController fromNewOutfitButton == \(true)")
        //        } else if segue.identifier == "GoTodayOutfitSegue" {
        //            let controller = segue.destination as! SavedOutfitViewController
        //            controller.items = todaysOutfit
        //        }
    }
}
