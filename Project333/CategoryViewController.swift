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

class CategoryViewController: UITableViewController{
    
    let ClothesCategory = ["Tops","Bottoms","Shoes","Dresses","Accessories","Outerwear"]
    
    private var imagePicker: UIImagePickerController!
    var itemImage: UIImage!
    var isAddingItem: Bool = false
    
    override func viewWillAppear(_ animated: Bool) {
        print("value of isAddingItem == \(isAddingItem)")
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ClothesCategory.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell") as! CategoryViewCell
        
        cell.categoryCell.text = ClothesCategory[indexPath.row]
        if isEditing {
            cell.numItemsCell.text = "# items"
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "", message: "Clicked cell "+ClothesCategory[indexPath.row], preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
