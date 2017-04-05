//
//  PickOutfitViewController.swift
//  Project333
//
//  Created by Eric Wei on 2017-04-05.
//  Copyright © 2017 EricWei. All rights reserved.
//

import Foundation
import UIKit

class PickOutfitViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension PickOutfitViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PickCollectionCell", for: indexPath) as! PickItemViewCell
        cell.itemImageView.image = UIImage(named: "Placeholder")
        return cell
    }
    
}

extension PickOutfitViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ClothesArray.sharedDataSource().ClothesCategory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PickTableCell")!
        cell.textLabel?.text = ClothesArray.sharedDataSource().ClothesCategory[indexPath.row]
        
        return cell
    }
}
