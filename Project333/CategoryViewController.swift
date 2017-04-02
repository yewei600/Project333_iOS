//
//  CategoryViewController.swift
//  Project333
//
//  Created by Eric Wei on 2017-03-30.
//  Copyright © 2017 EricWei. All rights reserved.
//

import Foundation
import MobileCoreServices
import UIKit
import CoreData

class CategoryViewController: UITableViewController{
    
    let ClothesCategory = ["Tops","Bottoms","Shoes","Dresses","Accessories","Outerwear"]
    
    //    let topsSubcategory = ["Blazers","Shirts","Sweaters","T-shirts","Sleeveless"]
    //    let bottomsSubcategory = ["Shorts","Trousers","Skirts","Jeans"]
    //    let shoesSubcategory = ["Boots","Flats","Heels","Sandals"]
    //    let dresses = ["Gowns", "Cocktail Dresses","Strapless Dresses"]
    //    let accessoriesSubcategory = ["Watches","Sunglasses","Belts","Hats","Necklaces","Bracelets","Rings","Others"]
    
    var ClothesSubcategory = [["Blazers","Shirts","Sweaters","T-shirts","Sleeveless"],
                              ["Shorts","Trousers","Skirts","Jeans"],
                              ["Boots","Flats","Heels","Sandals"],
                              ["Gowns", "Cocktail Dresses","Strapless Dresses"],
                              ["Watches","Sunglasses","Belts","Hats","Necklaces","Bracelets","Rings","Others"],
                              ["Jackets","Coats"]]
    
    private var imagePicker: UIImagePickerController!
    var itemImage: UIImage!
    var isAddingItem: Bool!
    var chosenCategoryIndex: Int!
    var chosenCategory: String!
    
    
    //    override func viewWillAppear(_ animated: Bool) {
    //        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Item")
    //
    //    }
    
    
    override func viewDidLoad() {
        isAddingItem = false
    }
    //tableview methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("numberOfRowsInSection() called")
        return ClothesCategory.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("cellForRowAt() called   isEditing==\(isAddingItem)")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell") as! CategoryViewCell
        
        cell.categoryCell.text = ClothesCategory[indexPath.row]
        if isAddingItem {
            cell.numItemsCell.text = ""
        } else{
            cell.numItemsCell.text = "# items"
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt() called   isEditing==\(isEditing)")
        
        if isAddingItem {
            chosenCategory = ClothesCategory[indexPath.row]
            chosenCategoryIndex = indexPath.row
            self.performSegue(withIdentifier: "SubcategorySegue", sender: self)
        } else{
            let controller = self.storyboard!.instantiateViewController(withIdentifier: "ClothesCollectionViewController") as! ClothesCollectionViewController
            self.navigationController!.pushViewController(controller, animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as! SubcategoryViewController
        
        controller.subcategoryItems = ClothesSubcategory[self.chosenCategoryIndex]
        controller.category = chosenCategory
        controller.itemImage = self.itemImage
    }
    
    func showAlertView(message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showActionSheetAlert() {
        let choiceAlertMenu = UIAlertController(title: "Choose ", message: "Choose a category for the item", preferredStyle: .actionSheet)
        
        var actionButtons = [UIAlertAction]()
        
        for i in 0..<ClothesCategory.count {
            actionButtons[i] = UIAlertAction(title: "hello", style: .default, handler: nil)
            choiceAlertMenu.addAction(actionButtons[i])
        }
        self.present(choiceAlertMenu, animated: true, completion: nil)
    }
    
    @IBAction func addItemClicked(_ sender: Any) {
        //launch the photo activity: first step in adding item
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
        } else {
            imagePicker.sourceType = .photoLibrary
        }
        
        imagePicker.allowsEditing = true
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: imagePicker.sourceType)!
        self.present(imagePicker, animated: true, completion: nil)
    }
}

extension CategoryViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let mediaType = info[UIImagePickerControllerMediaType] as! String
        if mediaType == (kUTTypeImage as String) {
            itemImage = info[UIImagePickerControllerEditedImage] as? UIImage
            print(itemImage==nil)
            
        } else{
            //a video was taken
            print("no photo was taken")
        }
        dismiss(animated: true) {
            //self.showAlertView(message: "Choose a category for the item")
            self.navigationItem.title = "Choose a category for the item"
            self.isAddingItem = true
            self.tableView.reloadData()
        }
    }
    
}
