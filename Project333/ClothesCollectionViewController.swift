//
//  ClothesCollectionViewController.swift
//  Project333
//
//  Created by Eric Wei on 2017-04-01.
//  Copyright © 2017 EricWei. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class ClothesCollectionViewController: UICollectionViewController {
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    var CategoryIndex: Int!
    var clothesItems = [Item]()
    var numSubcategories: Int!
    var coreDataStack: CoreDataStack!
    
    override func viewWillAppear(_ animated: Bool) {
        numSubcategories = ClothesArray.sharedDataSource().ClothesSubcategory[CategoryIndex].count
        getPhotos()
    }
    
    override func viewDidLoad() {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        coreDataStack = delegate.stack
        setupViewCells()
    }
    
    //so I'm segueing from VC1 to VC2.   VC2 is a tableview. by clicking something in VC2, it should
    
    //collection view methods
    //    override func numberOfSections(in collectionView: UICollectionView) -> Int {
    //        return numSubcategories
    //    }
    //
    //    override func indexTitles(for collectionView: UICollectionView) -> [String]? {
    //        return ClothesArray.sharedDataSource().ClothesCategory
    //    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return clothesItems.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ClothesItemViewCell", for: indexPath) as! ClothesItemViewCell
        
        cell.clothesItemImage.image = UIImage(data: clothesItems[indexPath.row].imageData as! Data)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //able to identity the clothing item by clicking on its picture
        var chosenItem = clothesItems[indexPath.row]
        
        print("the chosen item has ID = \(chosenItem.objectID)")
        
    }
    
    func setupViewCells() {
        let space: CGFloat = 3.0
        let dimension = (self.view.frame.size.width - (2*space)) / 3.0
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = 0.1
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
    
    func getPhotos() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
        let sortDescriptor = NSSortDescriptor(key: "subcategory", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.predicate = NSPredicate(format: "category== %@", ClothesArray.sharedDataSource().ClothesCategory[CategoryIndex])
        
        if let fetchResults = try? coreDataStack.context.fetch(fetchRequest) as! [Item] {
            clothesItems = fetchResults
            print("got \(clothesItems.count) clothes items!")
        }
    }
    
}
