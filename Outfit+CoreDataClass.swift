//
//  Outfit+CoreDataClass.swift
//  Project333
//
//  Created by Eric Wei on 2017-04-05.
//  Copyright © 2017 EricWei. All rights reserved.
//

import Foundation
import CoreData

@objc(Outfit)
public class Outfit: NSManagedObject {
    
    convenience init(name: String, itemID: [URL], arrayName: String, context: NSManagedObjectContext) {
        if let ent = NSEntityDescription.entity(forEntityName: "Outfit", in: context) {
            self.init(entity: ent, insertInto: context)
            self.name = name
            self.itemID?.mutableArrayValue(forKey: arrayName)
        } else{
            fatalError("Unable to find Outfit Entity name!")
        }
    }
}
