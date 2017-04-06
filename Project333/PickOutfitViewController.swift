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
    
    //http://lybron.com/ios-programming-tutorials/2016/1/7/automatically-size-custom-uitableviewcell-to-fit-content
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    var newOutfitRequest: Bool?
    var coreDataStack: CoreDataStack!
    static var outfitItemIDs = [URL]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        coreDataStack = delegate.stack
        
        tableView.estimatedRowHeight = 97.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        setupViewCells()
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

    @IBAction func doneButtonPressed(_ sender: Any) {
//        let
//        for url in PickOutfitViewController.outfitItemIDs {
//            
//        }
    }
    
}

extension PickOutfitViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PickOutfitViewController.outfitItemIDs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PickCollectionCell", for: indexPath) as! PickItemViewCell
        
        let itemID = coreDataStack.context.persistentStoreCoordinator?.managedObjectID(forURIRepresentation: PickOutfitViewController.outfitItemIDs[indexPath.row])
        
        if let item = try? coreDataStack.context.object(with: itemID!) as! Item{
           cell.itemImageView.image = UIImage(data: item.imageData! as Data)
        }
        
        return cell
    }
    
    func setupViewCells() {
        let space: CGFloat = 3.0
        let dimension = (self.view.frame.size.width - (2*space)) / 3.0
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = 0.1
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "ClothesCollectionViewController") as! ClothesCollectionViewController
        controller.CategoryIndex = indexPath.row
        controller.isSelectingItems = true
        self.navigationController!.pushViewController(controller, animated: true)
    }
    
}
