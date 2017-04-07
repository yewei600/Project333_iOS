//
//  OutfitsTableViewController.swift
//  Project333
//
//  Created by Eric Wei on 2017-04-04.
//  Copyright © 2017 EricWei. All rights reserved.
//

import Foundation
import UIKit

//SAVED OUTFITS!
class OutfitsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var outfitsTableView: UITableView!
    var outfits = [String]()
    
    override func viewDidLoad() {
        print("Outfits table VC?? hello?")
        outfitsTableView.delegate = self
        outfitsTableView.dataSource = self
    }
    
    //tableview methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("savedOutfits table VC  cellForRowAt()")
        let cell = tableView.dequeueReusableCell(withIdentifier: "OutfitCell")!
        cell.textLabel?.text = "Hello!"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = self.storyboard!.instantiateViewController(withIdentifier: "OutfitViewController") as! OutfitViewController
        self.navigationController!.pushViewController(controller, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FromSavedOutfitsSegue" {
            let controller = segue.destination as! CustomNavController
            controller.fromNewOutfitButton = false
            print("set CustomNavController fromNewOutfitButton == \(false)")
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
